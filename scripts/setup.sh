#!/bin/bash

# Color codes
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[1;33m'
export CYAN='\033[0;36m'
export NC='\033[0m'

export CURRENT_DATE=$(date +%Y%m%d)

DOTFILES_PATH="$HOME/.dotfiles"
OS_TYPE=$(uname)

initial_setup() {
  if [[ "$OS_TYPE" == "Darwin" ]]; then
    printf "${CYAN}Detected macOS. Running macOS installation script...${NC}\n"
    # sh -c "$(curl -fsSL https://raw.githubusercontent.com/alwisidi/dotfiles/main/scripts/dependencies/mac.sh)"
    sh ./dependencies/mac.sh
  elif [[ "$OS_TYPE" == "Linux" ]]; then
    printf "Nothing to do here, come next time :)\n"
    # TODO later ...
  else
    printf "${RED}Unsupported operating system.${NC}\n"
    exit 1
  fi
}

stowing() {
  [ -d "$DOTFILES_PATH/.git" ] || git clone https://github.com/alwisidi/dotfiles.git $DOTFILES_PATH
  while true; do
    OUTPUT=$(stow -R --no-folding -d $DOTFILES_PATH -t $HOME . 2>&1)
    STATUS=$?
    if [ $STATUS -eq 0 ]; then
      printf "${GREEN}Stow completed successfully.${NC}\n"
      break
    fi

    # I hate custom regexing! it's gonna break in the future whenever stow decides to change their output syntax 😞
    echo "$OUTPUT" | sed -n -e 's/.*over existing target \([^ ]*\) .*/\1/p' -e 's/.*existing target is not owned by stow: \(.*\)/\1/p' | while read -r FILENAME; do
      FULL_PATH="$HOME/$FILENAME"
      if [ -L "$FULL_PATH" ]; then
        printf "${CYAN}Unlinking symbolic link: $FILENAME${NC}\n"
        unlink "$FULL_PATH"
      elif [ -e "$FULL_PATH" ]; then
        printf "${CYAN}Handling actual file: $FILENAME${NC}\n"
        mv "$FULL_PATH" "$FULL_PATH.backup.$(date +%Y-%m-%d_%H-%M-%S)"
        printf "${GREEN}Moved $FILENAME to $FILENAME.backup.$(date +%Y-%m-%d_%H-%M-%S)${NC}\n"
      else
        printf "${YELLOW}$FILENAME does not exist. Skipping.${NC}\n"
      fi
    done
  done
}

main() {
  printf "${CYAN}Preparing your magic environment ✨${NC}\n"
  initial_setup
  printf "${CYAN}Time to stow configuraitons 🍳${NC}\n"
  stowing
  printf "\n${GREEN}Your device is stowed and ready 🧑‍🍳${NC}\n"
}
main
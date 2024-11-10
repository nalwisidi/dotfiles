#!/bin/sh

# GitHub Account Username (Change it to yours if you fork this repo)
export GH_USERNAME="alwisidi"

# Global Variables
export CURRENT_DATE=$(date +%Y%m%d)
export DOTFILES_PATH="$HOME/.dotfiles"
export OS_TYPE=$(uname)

# Exit script on any command error
set -e

# Status functions
user () { printf "\r[ \033[0;33m??\033[0m ] $1\n"; }
info () { printf "\r[ \033[00;34m..\033[0m ] $1\n"; }
succ () { printf "\r\033[2K[ \033[00;32mOK\033[0m ] $1\n"; }
fail () { printf "\r\033[2K[\033[0;31mFAIL\033[0m] $1\n" && exit; }

install_essentials() {
  if [[ "$OS_TYPE" == "Darwin" ]]; then
    info "Detected macOS."
    if ! command -v brew &> /dev/null; then
      info "Installing Homebrew..."
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      [[ $(command -v brew &> /dev/null) -eq 0 ]] &&
        succ "Homebrew installed successfully." ||
        fail "Homebrew installation failed."
    fi
    curl -sL "https://raw.githubusercontent.com/$GH_USERNAME/dotfiles/main/Brewfile" | brew bundle --file=-
  elif [[ "$OS_TYPE" == "Linux" ]]; then
    info "Nothing to do here, come next time :)"
    # TODO later ...
  else
    fail "Unsupported operating system."
  fi
}

initial_setup() {
  info "Configuring your favorite tools 💫🛠️"
  # 1- Git configuraitons
  if ! [ -f $HOME/.gitconfig ]; then
    info 'Setup gitconfig'
    user ' - What is your Git author name?'
    read -e GIT_AUTHORNAME
    user ' - What is your Git author email?'
    read -e GIT_EMAIL
    echo -e "[user]\n\tname = $GIT_AUTHORNAME\n\temail = $GIT_EMAIL\n[init]\n\tdefaultBranch = main\n[core]\n\texcludesfile = /Users/me/.config/git/.gitignore" > $HOME/.gitconfig
    succ "gitconfig initialized successfully."
  fi
  # 2- iTerm2 configurations (if macOS)
  if [[ "$OS_TYPE" == "Darwin" ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/$GH_USERNAME/dotfiles/main/.config/iterm2/iterm2_setup.sh)"
  fi
}

stow_dotfiles() {
  [ -d "$DOTFILES_PATH/.git" ] || git clone https://github.com/$GH_USERNAME/dotfiles.git $DOTFILES_PATH
  while true; do
    OUTPUT=$(stow -R --no-folding -d $DOTFILES_PATH -t $HOME . 2>&1)
    STATUS=$?
    if [ $STATUS -eq 0 ]; then
      succ "Stow completed successfully." && break
    fi
    # WARNING This regex might break in the future whenever stow's output changes
    echo "$OUTPUT" | sed -n -e 's/.*over existing target \([^ ]*\) .*/\1/p' -e 's/.*existing target is not owned by stow: \(.*\)/\1/p' | while read -r FILENAME; do
      FULL_PATH="$HOME/$FILENAME"
      if [ -L "$FULL_PATH" ]; then
        unlink "$FULL_PATH"
        info "Unlinking symbolic link: $FILENAME"
      elif [ -e "$FULL_PATH" ]; then
        mv "$FULL_PATH" "$FULL_PATH.backup.$CURRENT_DATE"
        succ "Moved $FILENAME to $FILENAME.backup.$CURRENT_DATE"
      else
        info "$FILENAME does not exist. Skipping.."
      fi
    done
  done
}

main() {
  info "Preparing your magic environment ✨"
  install_essentials
  initial_setup
  info "Time to stow configuraitons 🍳"
  stow_dotfiles
  succ "Your device is stowed and ready 🧑‍🍳"
}
main

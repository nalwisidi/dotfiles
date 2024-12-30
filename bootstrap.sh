#!/bin/sh

# GitHub Account Username (Change it to yours if you fork this repo)
export GH_USERNAME="nalwisidi"

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
    curl -sL "https://raw.githubusercontent.com/$GH_USERNAME/dotfiles/main/Brewfile?$(date +%s)" | brew bundle --file=-
  elif [[ "$OS_TYPE" == "Linux" ]]; then
    info "Nothing to do here, come next time :)"
    # TODO later ...
  else
    fail "Unsupported operating system."
  fi
}

initial_setup() {
  CFG="$HOME/.config"
  # Clone the ZPLUG repo if not present
  ZPLUG_PATH="$CFG/zsh/zplug"
  [ -d "$ZPLUG_PATH/.git" ] || git clone --depth=1 https://github.com/zplug/zplug.git $ZPLUG_PATH

  # Clone the OH-MY-ZSH repo if not present
  OMZ_PATH="$CFG/zsh/.oh-my-zsh"
  [ -d "$OMZ_PATH/.git" ] || git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git $OMZ_PATH

  # Clone the POWERLEVEL10K repo if not present
  P10K_PATH="$OMZ_PATH/custom/themes/powerlevel10k"
  [ -d "$P10K_PATH/.git" ] || git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $P10K_PATH

  # Clone the NvChad repo if not present
  NVIM_PATH="$CFG/nvim"
  [ -d "$NVIM_PATH/.git" ] || git clone --depth=1 https://github.com/NvChad/starter $NVIM_PATH

  # Clone the TPM repo if not present
  TPM_PATH="$CFG/tmux/plugins/tpm"
  [ -d "$TPM_PATH/.git" ] || git clone --depth=1 https://github.com/tmux-plugins/tpm.git $TPM_PATH

# info "Configuring your favorite tools 💫🛠️"
# # 1- Git configuraitons
# if ! [ -f $HOME/.gitconfig ]; then
#   info 'Setup Git config file'
#   user ' - What is your Git author name?'
#   read -e GIT_AUTHORNAME
#   user ' - What is your Git author email?'
#   read -e GIT_EMAIL
#   echo -e "[user]\n\tname = $GIT_AUTHORNAME\n\temail = $GIT_EMAIL\n[init]\n\tdefaultBranch = main\n[core]\n\texcludesfile = /Users/me/.config/git/.gitignore" > $HOME/.gitconfig
#   succ "gitconfig initialized successfully."
# fi
# # 2- iTerm2 configurations (if macOS)
# if [[ "$OS_TYPE" == "Darwin" ]]; then
#   info 'Setup iTerm2 preferences'
#   sh -c $(curl -fsSL "https://raw.githubusercontent.com/$GH_USERNAME/dotfiles/main/.config/iterm2/iterm2_setup.sh?$(date +%s)")
#   info 'github_dark theme imported to iTerm2, please, apply it manually'
#   curl -sL "https://raw.githubusercontent.com/$GH_USERNAME/dotfiles/main/.config/iterm2/github_dark.itermcolors?$(date +%s)" -o /tmp/github_dark.itermcolors && open /tmp/github_dark.itermcolors && rm /tmp/github_dark.itermcolors &> /dev/null
#   succ "iTerm2 configured successfully."
# fi
}

stow_dotfiles() {
  # Clone the dotfiles repo if not present
  [ -d "$DOTFILES_PATH/.git" ] || git clone --depth=1 https://github.com/$GH_USERNAME/dotfiles.git $DOTFILES_PATH

  # Check for conflicts before running stow
  CONFLICTS=$(stow -n --no-folding -d "$DOTFILES_PATH" -t "$HOME" . 2>&1 | sed -n -e 's/.*over existing target \([^ ]*\) .*/\1/p')

  # Handle conflicts
  for FILENAME in $CONFLICTS; do
    FULL_PATH="$HOME/$FILENAME"
    if [ -L "$FULL_PATH" ]; then
      unlink "$FULL_PATH"
      echo "ℹ Unlinked symbolic link: $FULL_PATH"
    elif [ -f "$FULL_PATH" ]; then
      mv "$FULL_PATH" "$FULL_PATH.backup.$(date +%Y%m%d%H%M%S)"
      echo "✔ Backed up file: $FULL_PATH to $FULL_PATH.backup.$(date +%Y%m%d%H%M%S)"
    elif [ -d "$FULL_PATH" ]; then
      mv "$FULL_PATH" "$FULL_PATH.backup.$(date +%Y%m%d%H%M%S)"
      echo "✔ Backed up directory: $FULL_PATH to $FULL_PATH.backup.$(date +%Y%m%d%H%M%S)"
    fi
  done

  # Run stow after resolving conflicts
  stow -R --no-folding -d "$DOTFILES_PATH" -t "$HOME" .
  if [ $? -eq 0 ]; then
    echo "✔ Stow completed successfully."
  else
    echo "❌ Stow failed. Check logs for details."
  fi
}



main() {
  info "Preparing your magic environment ✨"
# install_essentials
  initial_setup
  info "Time to stow configuraitons 🍳"
  stow_dotfiles
  succ "Your device is stowed and ready 🧑‍🍳"
}
main

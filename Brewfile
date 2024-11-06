#!/bin/zsh

if ! command -v brew &> /dev/null; then
  printf "${YELLOW}Homebrew is not installed. Installing Homebrew...${NC}\n"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if ! command -v brew &> /dev/null; then
    printf "${RED}Homebrew installation failed.${NC}\n"
    exit 1
  else
    printf "${GREEN}Homebrew installed successfully.${NC}\n"
  fi
else
  printf "${CYAN}Homebrew is already installed.${NC}\n"
fi

install_apps() {
  APP_TYPE=$1
  APPS_LIST=("${@:2}")
  for app in "${APPS_LIST[@]}"; do
    if brew list --cask "$app" &>/dev/null || brew list "$app" &>/dev/null; then
      printf "${GREEN}$app is already installed. Skipping.${NC}\n"
      continue
    fi

    if [[ "$APP_TYPE" == "gui" ]]; then
      printf "${CYAN}Installing $app (GUI application)...${NC}\n"
      brew install --cask "$app" &> "/tmp/install_${app}_$CURRENT_DATE.log" &
    else
      printf "${CYAN}Installing $app (CLI tool)...${NC}\n"
      brew install "$app" &> "/tmp/install_${app}_$CURRENT_DATE.log" &
    fi
    if [ $? -ne 0 ]; then
      printf "${RED}Failed to install $app.${NC}\n"
    else
      printf "${GREEN}$app installed successfully.${NC}\n"
    fi
  done
  wait
}

# Essential CLI Apps
essential_cli_apps=("git" "stow" "telnet" "netcat" "archey4" "powerlevel10k" "zsh-completions" "zsh" "coreutils" "fzf" "bat" "lf" "tree" "jq" "yq" "wget" "neovim" "p7zip" "python" "node" "openjdk")
printf "${CYAN}Installing Essential CLI applications ...${NC}\n"
install_apps "cli" "${essential_cli_apps[@]}"

# DEV CLI Apps
dev_cli_apps=("docker-completion" "kubernetes-cli" "openshift-cli" "terraform" "ansible" "argocd" "vault" "helm")
printf "${CYAN}Installing DEV CLI applications ...${NC}\n"
install_apps "cli" "${dev_cli_apps[@]}"

# Extra CLI Apps
extra_cli_apps=("cryptography" "dnsmasq" "nmap")
printf "${CYAN}Installing Extra CLI applications ...${NC}\n"
install_apps "cli" "${extra_cli_apps[@]}"


# Essential GUI Apps
essential_gui_apps=("keepingyouawake" "cleanmymac" "rectangle" "onedrive" "raycast" "iterm2" "maccy" "stats" "arc" "vlc")
printf "${CYAN}Installing Extra GUI applications ...${NC}\n"
install_apps "gui" "${extra_gui_apps[@]}"

# DEV GUI Apps
dev_gui_apps=("visual-studio-code" "microsoft-edge" "postman" "docker" "lens")
printf "${CYAN}Installing DEV GUI applications ...${NC}\n"
install_apps "gui" "${dev_gui_apps[@]}"

# Extra GUI Apps
extra_gui_apps=("keystore-explorer" "aldente" "discord" "stremio" "notion")
printf "${CYAN}Installing Extra GUI applications ...${NC}\n"
install_apps "gui" "${extra_gui_apps[@]}"
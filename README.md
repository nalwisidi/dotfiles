# Dotfiles Project

## Overview
This repository contains my personal configuration files and automated setup scripts for macOS, with plans to expand to Linux and Windows. The project is designed to streamline the configuration and setup process for a consistent development environment across platforms.

## Features
- **Automated Setup**: One-command script to set up the entire device, including cloning the repository and stowing configurations.
- **Cross-Platform Support**: Currently complete for macOS, with Linux and Windows configurations coming soon.
- **Shell Customization**: Optimized `zsh` setup with themes and plugins.
- **Tool Integrations**: Configuration files for essential development and productivity tools integrating Auto-Completion for various tools.
- **Package Management**: Utilizes `brew`, `choco`, and other package managers for installing applications and managing dependencies.
- **Symlink Management**: Uses `stow` for efficiently linking configuration files.

## Tools Used for macOS

### Productivity Tools
- **Raycast**: Alternative for Spotlight with advanced capabilities.
- **Rectangle**: Window management.
- **Maccy**: Clipboard manager.
- **Notion**: Best note-taking app ever 🤩.
- **Stats**: System resource monitoring in menubar.
- **KeepingYouAwake**: Prevents system sleep.
- **CleanMyMac**: System maintenance and optimization.

### Development Tools
- **iTerm2**: Enhanced terminal.
- **Visual Studio Code**: Main code editor.
- **Neovim**: Lightweight, customizable code editor.
- **Git**: Version control system.
- **Homebrew**: Package manager for easy software management.
- **Docker**: Containerization platform for development and deployment.
- **Ansible**: Automation tool for infrastructure management.
- **kubectl**: CLI tool for Kubernetes.
- **Terraform**: Infrastructure as code tool.
- **Vault**: Secure secrets management.
- **ArgoCD**: GitOps continuous delivery for Kubernetes.

## Structure
```
dotfiles/
├── .zshrc
├── .config/
│   └── iterm2/
│       └── preferences.json
├── scripts/
    ├── setup.sh  # Main script for setup automation
    └── dependencies/
        ├── mac.sh
        └── linux.sh
```

## Installation
To set up your macOS environment, run the following command:
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/alwisidi/dotfiles/main/scripts/setup.sh)"
```
This command will:
- Install brew (Package Manager).
- Install essential and recommended CLI and GUI applications.
- Clone the repository.
- Stow configurations automatically.

### Future Updates
- **Linux**: Upcoming automation scripts and configurations.
- **Windows**: Planned PowerShell profile and setup automation.

## Usage
Simply run the setup script to install and link the necessary configuration files for your environment.

## License
This project is licensed under the GPL License. See the [LICENSE](./LICENSE) file for details.

## Acknowledgements
Gratitude to the open-source community for tools and inspiration that made this project possible 🌟✨🙏
Your contributions and shared knowledge help developers worldwide improve their workflows and create efficient environments 🚀🛠️
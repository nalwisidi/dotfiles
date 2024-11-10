# Dotfiles Project

## Overview
This repository contains my personal configuration files for development and specially for **DevOps**, and automated setup script for macOS, with plans to expand to Linux and Windows.

## Installation
To set up your macOS environment, run the following command:
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/alwisidi/dotfiles/main/bootstrap.sh)"
```
This command will:
- Install `brew` package manager (if not already installed).
- Install my preferred CLI and GUI tools.
- Clone the repository.
- Stow configurations automatically.

## My Setup Tools (macOS)
### Productivity Tools
- **Raycast**: Alternative for Spotlight with advanced capabilities (Free version is more than enough).
- **Rectangle**: Window management via shortcuts.
- **Stats**: System resource monitoring (in menubar).
- **Maccy**: Clipboard manager (in menubar).
- **KeepingYouAwake**: Prevents system sleep (in menubar).
- **CleanMyMac**: Advanced System maintenance and optimization (Paid).
- **AlDente Pro**: Customizes charging limits to extend battery health (Paid).

### Main CLI Tools
- **lf**: Advanced file manager.
- **nvim**: Customized version with support to many IDE features (a fork from nvchad).
- **tmux**: Allows multiple terminal sessions in one window with persistent sessions.

---
The repo includes more tools not listed here—explore to discover them all 😉


## Repo File Structure
```
dotfiles/
├── .zprofile
├── .config/
│   ├── git/
│   │   └── .gitignore
│   ├── iterm2/
│   │   ├── zsh_scripts/*
│   │   ├── iterm2_setup.sh
│   │   └── github_dark.itermcolors
│   ├── lf/
│   │     └── lfrc
│   ├── nvim/
│   │   ├── lua/*
│   │   ├── init.lua
│   │   └── .stylua.toml
│   ├── shell/
│   │     └── profile
│   ├── tmux/
│   │     └── tmux.conf
│   └── zsh/
│       ├── .zshrc
│       ├── themes.zsh
│       ├── aliases.zsh
│       ├── iterm2_shell_integration.zsh
│       ├── tab.zsh
│       ├── plugins.zsh
│       └── p10k.zsh
├── bootstrap.sh # script to bootstrap my dotfiles and install needed packages
└── Brewfile
```

### Future Updates
- **Linux**: Include installation and configurations function for Linux (Personal + Jump + Workers) to `bootstrap.sh`.
- **Windows**: Code PowerShell script and setup automation including WSL, etc..

## License
This project is licensed under the GPL License. See the [LICENSE](./LICENSE) file for details.

## Acknowledgements
Gratitude to the open-source community for the tools and support that made this project possible. 🌟✨🙏

---
Special thanks for [Luke Smith](https://github.com/LukeSmithxyz), [Elliott Minns](https://github.com/elliottminns), and [Zach Holman](https://github.com/holman) for their inspiration and sharing their knowledge and work.
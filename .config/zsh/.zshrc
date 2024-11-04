# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
setopt inc_append_history

source $ZDOTDIR/themes.zsh
source $ZDOTDIR/plugins.zsh
source $ZDOTDIR/aliases.zsh

# BUN Configs
export BUN_INSTALL="$XDG_LOCAL_HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Load auto completions
source $ZDOTDIR/tab.zsh

# iTerm2 & ZSH integration
if [[ "$(uname)" == "Darwin" ]]; then
  [[ ! -f $ZDOTDIR/.iterm2_shell_integration.zsh ]] || source $ZDOTDIR/.iterm2_shell_integration.zsh
fi

# Integrate FZF
eval "$(fzf --zsh)"


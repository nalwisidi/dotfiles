# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="$XDG_DATA_HOME/zsh_history"
setopt inc_append_history

source $ZDOTDIR/themes.zsh
source $ZDOTDIR/aliases.zsh

# BUN Configs
export BUN_INSTALL="$XDG_LOCAL_HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# iTerm2 & ZSH integration
if [[ "$(uname)" == "Darwin" ]]; then
  [[ ! -f $ZDOTDIR/iterm2_shell_integration.zsh ]] || source $ZDOTDIR/iterm2_shell_integration.zsh
fi

# Integrate FZF
eval "$(fzf --zsh)"

# Integrate Zoxide
eval "$(zoxide init zsh)"

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Edit line in VI with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey -M viins '^e' edit-command-line
bindkey -M vicmd '^e' edit-command-line

# Auto navigate with CLI File Manager (lf)
lfcd () {
  tmp="$(mktemp -uq)"
  trap 'rm -f $tmp >/dev/null 2>&1' EXIT
  command lf -last-dir-path="$tmp" "$@"
  if [ -f "$tmp" ]; then
    dir="$(cat "$tmp")"
    [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
  fi
  clear
}
alias lf='lfcd'
bindkey -s '^o' '^ulfcd\n'

# Ctrl+z -> reload zsh
bindkey -s '^z' 'source ~/.config/zsh/.zshrc\n'

# Load auto completions
source $ZDOTDIR/tab.zsh

# Load plugins
source $ZDOTDIR/plugins.zsh


# Export Variables for LevelDB
export CPLUS_INCLUDE_PATH=$(brew --prefix leveldb)/include
export LDFLAGS="-L$(brew --prefix leveldb)/lib"

# -- Auto Completions Loader -- #
# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)	# Include hidden files.

# BUN
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"

# Helm
autoload -Uz compinit && compinit && source <(helm completion zsh)

# Docker
autoload -Uz compinit && compinit && source <(docker completion zsh)

# Kubernetes
autoload -Uz compinit && compinit && source <(kubectl completion zsh)
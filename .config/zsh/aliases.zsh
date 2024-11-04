# Use neovim for vi & vim if present.
[ -x "$(command -v nvim)" ] && alias vi="nvim" vim="nvim"

# SUDO not required for some system commands
for command in mount umount sv pacman updatedb su shutdown poweroff reboot ; do
	alias $command="sudo $command"
done; unset command

# Search and edit a script from $HOME/.local/bin using fzf and default editor
se() {
	choice="$(find $HOME/.local/bin -mindepth 1 -printf '%P\n' | fzf)"
	[ -f "$HOME/.local/bin/$choice" ] && $EDITOR "$HOME/.local/bin/$choice"
}

# Verbose and enhance commands
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -vI"
alias bc="bc -ql"
alias mkd="mkdir -pv"
alias tree='tree -I ".git" -a'
alias rsync="rsync -vrPlu"
# alias yt="yt-dlp --embed-metadata -i"
# alias yta="yt -x -f bestaudio/best"
# alias ytt="yt --skip-download --write-thumbnail"
# alias ffmpeg="ffmpeg -hide_banner"

# Colorize commands
alias ip="ip -color=auto"
alias grep="grep --color=auto"
alias diff="diff --color=auto"
alias ccat="highlight --out-format=ansi"

# Productivity aliases (Networking and DEV)
alias gh='cat /etc/hosts | grep -i'
alias hosts="sudo $EDITOR /etc/hosts"

# macOS aliases
if [[ "$(uname)" == "Darwin" ]]; then
  alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
  alias ls="gls -hN --color=auto --group-directories-first"
  alias ll="ls -ltr"
  alias py='/opt/homebrew/bin/python3'
  alias pip='/opt/homebrew/bin/pip3.12'
  alias python='/opt/homebrew/bin/python3'

  # Reload Tiling Window Manager (YABAI) & SKHD
  reload_wm () {
    yabai  --stop-service && skhd  --stop-service &&
    yabai --start-service && skhd --start-service
  }
fi

# -- Kubernetes -- #
# Change namespace -> ns <desired_namespace>
ns () {
  kubectl config set-context $(kubectl config current-context) --namespace=$1
}
# Get working nodes IPs
alias nodes='kubectl get nodes | grep -Eo "([0-9]{1,3}\.){3}[0-9]{1,3}"'

# Stow
alias restow="stow -R --no-folding -d $DOTFILES_PATH -t $HOME ."
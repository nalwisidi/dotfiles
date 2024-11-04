# -- Default way to add supported plugins -- #
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# -- ZSH General Configurations and Plugin Manager -- #
export ZPLUG_HOME="$HOME/.config/zsh/zplug"
source $ZPLUG_HOME/init.zsh
zplug "mafredri/zsh-async", from:github
zplug "zsh-users/zsh-completions", from:github
zplug load
# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
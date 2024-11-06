if [[ -o interactive ]]; then
  if [ "${ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX-}""$TERM" != "tmux-256color" -a "${ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX-}""$TERM" != "screen" -a "${ITERM_SHELL_INTEGRATION_INSTALLED-}" = "" -a "$TERM" != linux -a "$TERM" != dumb ]; then
    ITERM_SHELL_INTEGRATION_INSTALLED=Yes
    ITERM2_SHOULD_DECORATE_PROMPT="1"
    iterm2_before_cmd_executes() {
      if [ "$TERM_PROGRAM" = "iTerm.app" ]; then
        printf "\033]133;C;\r\007"
      else
        printf "\033]133;C;\007"
      fi
    }
    iterm2_set_user_var() {
      printf "\033]1337;SetUserVar=%s=%s\007" "$1" $(printf "%s" "$2" | base64 | tr -d '\n')
    }
    whence -v iterm2_print_user_vars > /dev/null 2>&1
    if [ $? -ne 0 ]; then
      iterm2_print_user_vars() {
          true
      }
    fi
    iterm2_print_state_data() {
      local _iterm2_hostname="${iterm2_hostname-}"
      if [ -z "${iterm2_hostname:-}" ]; then
        _iterm2_hostname=$(hostname -f 2>/dev/null)
      fi
      printf "\033]1337;RemoteHost=%s@%s\007" "$USER" "${_iterm2_hostname-}"
      printf "\033]1337;CurrentDir=%s\007" "$PWD"
      iterm2_print_user_vars
    }
    iterm2_after_cmd_executes() {
      printf "\033]133;D;%s\007" "$STATUS"
      iterm2_print_state_data
    }
    iterm2_prompt_mark() {
      printf "\033]133;A\007"
    }
    iterm2_prompt_end() {
      printf "\033]133;B\007"
    }
    iterm2_decorate_prompt() {
      ITERM2_PRECMD_PS1="$PS1"
      ITERM2_SHOULD_DECORATE_PROMPT=""
      local PREFIX=""
      if [[ $PS1 == *"$(iterm2_prompt_mark)"* ]]; then
        PREFIX=""
      elif [[ "${ITERM2_SQUELCH_MARK-}" != "" ]]; then
        PREFIX=""
      else
        PREFIX="%{$(iterm2_prompt_mark)%}"
      fi
      PS1="$PREFIX$PS1%{$(iterm2_prompt_end)%}"
      ITERM2_DECORATED_PS1="$PS1"
    }
    iterm2_precmd() {
      local STATUS="$?"
      if [ -z "${ITERM2_SHOULD_DECORATE_PROMPT-}" ]; then
        iterm2_before_cmd_executes
        if [ "$PS1" != "${ITERM2_DECORATED_PS1-}" ]; then
          ITERM2_SHOULD_DECORATE_PROMPT="1"
        fi
      fi
      iterm2_after_cmd_executes "$STATUS"
      if [ -n "$ITERM2_SHOULD_DECORATE_PROMPT" ]; then
        iterm2_decorate_prompt
      fi
    }
    iterm2_preexec() {
      PS1="$ITERM2_PRECMD_PS1"
      ITERM2_SHOULD_DECORATE_PROMPT="1"
      iterm2_before_cmd_executes
    }
    if [ -z "${iterm2_hostname-}" ]; then
      if [ "$(uname)" != "Darwin" ]; then
        iterm2_hostname=`hostname -f 2>/dev/null`
        if [ $? -ne 0 ]; then
          iterm2_hostname=`hostname`
        fi
      fi
    fi
    [[ -z ${precmd_functions-} ]] && precmd_functions=()
    precmd_functions=($precmd_functions iterm2_precmd)
    [[ -z ${preexec_functions-} ]] && preexec_functions=()
    preexec_functions=($preexec_functions iterm2_preexec)
    iterm2_print_state_data
    printf "\033]1337;ShellIntegrationVersion=14;shell=zsh\007"
  fi
fi
alias imgcat="${XDG_CONFIG_HOME}/iterm2/scripts/imgcat"
alias imgls="${XDG_CONFIG_HOME}/iterm2/scripts/imgls"
alias it2api="${XDG_CONFIG_HOME}/iterm2/scripts/it2api"
alias it2attention="${XDG_CONFIG_HOME}/iterm2/scripts/it2attention"
alias it2check="${XDG_CONFIG_HOME}/iterm2/scripts/it2check"
alias it2copy="${XDG_CONFIG_HOME}/iterm2/scripts/it2copy"
alias it2dl="${XDG_CONFIG_HOME}/iterm2/scripts/it2dl"
alias it2getvar="${XDG_CONFIG_HOME}/iterm2/scripts/it2getvar"
alias it2git="${XDG_CONFIG_HOME}/iterm2/scripts/it2git"
alias it2setcolor="${XDG_CONFIG_HOME}/iterm2/scripts/it2setcolor"
alias it2setkeylabel="${XDG_CONFIG_HOME}/iterm2/scripts/it2setkeylabel"
alias it2tip="${XDG_CONFIG_HOME}/iterm2/scripts/it2tip"
alias it2ul="${XDG_CONFIG_HOME}/iterm2/scripts/it2ul"
alias it2universion="${XDG_CONFIG_HOME}/iterm2/scripts/it2universion"
alias it2profile="${XDG_CONFIG_HOME}/iterm2/scripts/it2profile"
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
alias imgcat=${ZDOTDIR}/.iterm2/imgcat;alias imgls=${ZDOTDIR}/.iterm2/imgls;alias it2api=${ZDOTDIR}/.iterm2/it2api;alias it2attention=${ZDOTDIR}/.iterm2/it2attention;alias it2check=${ZDOTDIR}/.iterm2/it2check;alias it2copy=${ZDOTDIR}/.iterm2/it2copy;alias it2dl=${ZDOTDIR}/.iterm2/it2dl;alias it2getvar=${ZDOTDIR}/.iterm2/it2getvar;alias it2git=${ZDOTDIR}/.iterm2/it2git;alias it2setcolor=${ZDOTDIR}/.iterm2/it2setcolor;alias it2setkeylabel=${ZDOTDIR}/.iterm2/it2setkeylabel;alias it2tip=${ZDOTDIR}/.iterm2/it2tip;alias it2ul=${ZDOTDIR}/.iterm2/it2ul;alias it2universion=${ZDOTDIR}/.iterm2/it2universion;alias it2profile=${ZDOTDIR}/.iterm2/it2profile

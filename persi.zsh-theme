prompt_writable() {
    if [ ! -w "$PWD" ]; then
        echo " "🔐
    fi
}

prompt_pwd() {
    local PERSI_PWD=${PWD/#$HOME/'~'}
    if [ "${PERSI_PWD}" != "~" ]; then
        PERSI_PWD=${PERSI_PWD##*/}
    fi
    echo ${PERSI_PWD}
}

prompt_user_identifier(){
    if [ "${USER}" = "root" ]; then
        echo "%{$fg[red]%} # %{$reset_color%}"
    else
        echo "%{$fg[black]%} $ %{$reset_color%}"
    fi
}

prompt_hostname(){
    echo $(hostname)
}

local ret_status="%(:%{$fg[green]%}@%{$fg[red]%}:)"
PROMPT='%{$fg[magenta]%}$(id -u)@$(prompt_hostname)%{$reset_color%}%{$fg[blue]%}${ret_status}%{$fg[FF5765]%}@%{$fg_bold[green]%}$(prompt_pwd)$(prompt_writable)%{$reset_color%}$(git_prompt_info)%{$reset_color%}$(prompt_user_identifier)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=" ⚡️ %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" "💥
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" "💫


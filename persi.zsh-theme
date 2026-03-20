#!/usr/bin/env zsh
# Optimized ZSH Theme Configuration - Full Path Version

# 1. Enable vcs_info
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr ' 💥'
zstyle ':vcs_info:*' stagedstr ' 💥'
zstyle ':vcs_info:*' actionformats '(%b|%a%u%c)'
zstyle ':vcs_info:*' formats '(%b%u%c)'
zstyle ':vcs_info:*' nvcsformats ''

zstyle ':vcs_info:git*' get-revision true
zstyle ':vcs_info:git*' check-for-changes true
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

+vi-git-untracked() {
    if [[ $(git status --porcelain 2>/dev/null | grep '^??' | wc -l) -gt 0 ]]; then
        hook_com[unstaged]=' ✨'
    fi
}

# 2. Define prompt building functions
__persiliao_build_user_host() {
    local user_color="%F{magenta}"
    [[ "$USER" == "root" ]] && user_color="%F{red}"

    local full_name=$(id -F 2>/dev/null || whoami)

    if [[ "$OSTYPE" == darwin* ]]; then
        echo "%B${user_color}${full_name}%f%b "
    else
        echo "%B${user_color}${full_name}%f%F{blue}@%f%F{magenta}%m%f%b "
    fi
}

__persiliao_build_pwd() {
    # Current working directory, home directory replaced with 🏡
    local pwd_display
    pwd_display=${PWD/#$HOME/🏡}
    if [[ "$pwd_display" == "🏡" ]]; then
        echo "%B%F{green}🏡%f%b"
    else
        # Show only the last directory level
        echo "%B%F{green}📂 ${pwd_display:t}%f%b"
    fi
}

__persiliao_build_permission_indicator() {
    if [[ ! -w "$PWD" ]]; then
        echo " 🔐"
    fi
}

__persiliao_build_git_info() {
    vcs_info
    if [[ -n ${vcs_info_msg_0_} ]]; then
        echo " %B%F{magenta}${vcs_info_msg_0_}%f%b"
    fi
}

local __persiliao_last_exit_status=0

__persiliao_precmd() {
    __persiliao_last_exit_status=$?
}

add-zsh-hook precmd __persiliao_precmd

__persiliao_build_prompt_char() {
    local color
    local symbol

    if [[ $__persiliao_last_exit_status -eq 0 ]]; then
        # Previous command succeeded
        if [[ "$USER" == "root" ]]; then
            color="cyan"
            symbol="#"
        else
            color="cyan"
            symbol="$"
        fi
    else
        # Previous command failed (including command not found)
        if [[ "$USER" == "root" ]]; then
            color="red"
            symbol="#"
        else
            color="red"
            symbol="$"
        fi
    fi

    echo "%F{$color}$symbol%f"
}

# 3. Set up prompt
setopt prompt_subst
precmd() {
    vcs_info
}

PROMPT='$(__persiliao_build_user_host)%F{green}$(__persiliao_build_pwd)$(__persiliao_build_permission_indicator)%f$(__persiliao_build_git_info) $(__persiliao_build_prompt_char) '

# 4. Optional: Right prompt for time display
RPROMPT='%B%F{242}%D{%H:%M:%S}%f%b'

# 5. LS color configuration remains unchanged
export CLICOLOR=1
export LSCOLORS="exfxcxdxbxegedabagacad"
export LS_COLORS='no=00:fi=00:di=01;32:ln=00;36:pi=40;33:so=01;35:do=01;35:bd=00;33;01:cd=40;33;01:or=41;33;01:ex=00;32:*.cmd=00;32:*.exe=01;32:*.com=01;32:*.bat=01;32:*.btm=01;32:*.dll=01;32:*.tar=00;31:*.tbz=00;31:*.tgz=00;31:*.rpm=00;31:*.deb=00;31:*.arj=00:31:*.taz=00:31:*.lzh=00:31:*.lzma=00:31:*.zip=00:31:*.zoo=00:31:*.z=00:31:*.Z=00:31:*.gz=00:31:*.bz2=00:31:*.tb2=00:31:*.tz2=00:31:*.tbz2=00:31:*.avi=01;35:*.bmp=01;35:*.fli=01;35:*.gif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mng=01;35:*.mov=01;35:*.mpg=01;35:*.pcx=01;35:*.pbm=01;35:*.pgm=01;35:*.png=01;35:*.ppm=01;35:*.tga=01;35:*.tif=01;35:*.xbm=01;35:*.xpm=01;35:*.dl=01;35:*.gl=01;35:*.wmv=01;35:*.aiff=00;32:*.au=00;32:*.mid=00;32:*.mp3=00;32:*.ogg=00;32:*.voc=00;32:*.wav=00;32:*.log=02;34:*.zip=01;32:'

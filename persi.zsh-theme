#!/usr/bin/env zsh
# Optimized ZSH Theme Configuration - Full Path Version

# 1. Enable vcs_info
# Load vcs_info module
autoload -Uz vcs_info

# Enable version control systems
zstyle ':vcs_info:*' enable git

# Basic configuration: detect changes
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' get-revision true

# Define state display characters
# Set both to empty initially, hook will control display
zstyle ':vcs_info:*' unstagedstr ''
zstyle ':vcs_info:*' stagedstr ''

# Format configuration
# Using only unstaged position (%u) for the emoji
zstyle ':vcs_info:*' formats '%b%u'        # Show only branch + unstaged (emoji)
zstyle ':vcs_info:*' actionformats '%b|%a%u'  # Action: branch|action + unstaged
zstyle ':vcs_info:*' nvcsformats ''

# Git-specific hook for any uncommitted changes
zstyle ':vcs_info:git*+set-message:*' hooks git-any-uncommitted

# Hook: Check for ANY uncommitted changes
+vi-git-any-uncommitted() {
    # Clear both states initially
    hook_com[unstaged]=''
    hook_com[staged]=''

    # Check if there are any uncommitted changes
    # git status --porcelain returns output for any changes
    if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
        # Any uncommitted change exists: show emoji in unstaged position
        hook_com[unstaged]=' 💥'
    fi
}

# 2. Define prompt building functions
__persiliao_build_user_host() {
    local user_color="%F{magenta}"
    [[ "$USER" == "root" ]] && user_color="%F{red}"

    local full_name=""
    if [[ "$OSTYPE" == darwin* ]]; then
      full_name=$(id -F)
    else
      full_name=$(id -nu)
    fi

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
# export LS_COLORS='no=00:fi=00:di=01;32:ln=00;36:pi=40;33:so=01;35:do=01;35:bd=00;33;01:cd=40;33;01:or=41;33;01:ex=00;32:*.cmd=00;32:*.exe=01;32:*.com=01;32:*.bat=01;32:*.btm=01;32:*.dll=01;32:*.tar=00;31:*.tbz=00;31:*.tgz=00;31:*.rpm=00;31:*.deb=00;31:*.arj=00:31:*.taz=00:31:*.lzh=00:31:*.lzma=00:31:*.zip=00:31:*.zoo=00:31:*.z=00:31:*.Z=00:31:*.gz=00:31:*.bz2=00:31:*.tb2=00:31:*.tz2=00:31:*.tbz2=00:31:*.avi=01;35:*.bmp=01;35:*.fli=01;35:*.gif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mng=01;35:*.mov=01;35:*.mpg=01;35:*.pcx=01;35:*.pbm=01;35:*.pgm=01;35:*.png=01;35:*.ppm=01;35:*.tga=01;35:*.tif=01;35:*.xbm=01;35:*.xpm=01;35:*.dl=01;35:*.gl=01;35:*.wmv=01;35:*.aiff=00;32:*.au=00;32:*.mid=00;32:*.mp3=00;32:*.ogg=00;32:*.voc=00;32:*.wav=00;32:*.log=02;34:*.zip=01;32:'

# 使用最安全、通用的 LS_COLORS
export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:"

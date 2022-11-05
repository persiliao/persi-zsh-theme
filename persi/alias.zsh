# Alias Commands

# Editor
alias -s js=vim
alias -s c=vim
alias -s java=vim
alias -s txt=vim
alias -s log=vim
alias -s php=vim
alias -s gz='tar -xzvf'
alias -s tgz='tar -xzvf'
alias -s zip='unzip'
alias -s bz2='tar -xjvf'
# required install unrar
#alias -s rar='unrar x'

function persi_lg()
{
    # shellcheck disable=SC2010
    ls -alhF|grep -v grep |grep -i "$1"
}

function persi_pg()
{
    ps -ef|grep -v grep |grep -i "$1"
}

function persi_netpg()
{
    netstat -an|grep -v grep|grep -i "$1"
}

function killProcessByLocalPort()
{
    local persi_process_port=$1
    # shellcheck disable=SC2155
    local persi_process_pid=$(lsof -i:${persi_process_port} |grep LISTEN|awk '{print $2}')
    # shellcheck disable=SC2046
    # shellcheck disable=SC2092
    sudo /bin/kill -9 "${persi_process_pid}"
}

# Zsh
alias tczero="truncate -s 0"
alias tczhistory="truncate -s 0 ~/.zsh_history"
alias ll="ls -alhF"
alias lg="persi_lg"
alias pg='persi_pg'
alias npg='persi_netpg'
alias rm="rm -ri"
# Generate rand password
alias grand="openssl rand -base64"
alias grand16="openssl rand -base64 16"
alias grand32="openssl rand -base64 32"

# Git
function persi_gacsp()
{
    local message=$1
    if [[ -z ${message} ]]; then
        showFailureMessage "Aborting commit due to empty commit message"
        return
    fi
    local branch=$(git_current_branch)
    git add . && git commit -m "${*}" && git pull origin "${branch}" && git submodule update --recursive --remote --merge && git add . && git commit -m "${*}" && git push origin "${branch}"
}

function persi_gacp()
{
    local message=$1
    if [ -z "${message}" ]; then
        showFailureMessage "Aborting commit due to empty commit message"
        return
    fi
    branch=$(git_current_branch)
    git add . && git commit -m "${*}" && git pull origin "${branch}" && git push origin "${branch}"
}

function persi_gacmsg()
{
    local message=$1
    if [ -z "${message}" ]; then
        showFailureMessage "Aborting commit due to empty commit message"
        return
    fi
    git add . && git commit -m "${*}"
}

function persi_gacmsgcp()
{
    git add . && git commit -m "chore: Code optimization"
}

function persi_gcmsg()
{
    local message=$1
    if [ -z "${message}" ]; then
        showFailureMessage "Aborting commit due to empty commit message"
        return
    fi
    git commit -m "${*}"
}

function persi_gacmsgd()
{
    local message=$1
    if [ -z "${message}" ]; then
        showFailureMessage "Aborting commit due to empty commit message"
        return
    fi
    git commit --amend -m "${*}"
}

function persi_gcmsgcp()
{
    git commit -m "chore: Code optimization"
}

function persi_gitPushAll()
{
    git remote -v|grep push|awk '{print $1}'|xargs -t -n 1 git push
}

alias gtdall='git tag |xargs git tag -d'
alias gct='git checkout test'
alias gmt='git merge test'
alias gmm='git merge master'
alias gmd='git merge develop'
alias ggpushmaster='git push origin $(git_main_branch)'
alias gsa='git submodule add'
alias gsui='git submodule update --init --recursive'
alias gsurm='git submodule update --recursive --remote --merge'
alias ggplsurm='git pull origin $(git_main_branch) && git submodule update --recursive --remote --merge'
alias gcmsg='persi_gcmsg'
alias gcmsgd='persi_gacmsgd'
alias gcmsgcp='persi_gcmsgcp'
alias gacmsg='persi_gacmsg'
alias gacmsgcp='persi_gacmsgcp'
alias gacsp='persi_gacsp'
alias gacp='persi_gacp'
alias ggpushall='persi_gitPushAll'

# System
function persi_showMemoryTopProcess()
{
    local number=$1
    if [ -z "${number}" ]; then
        number=10
    fi
    ps -ef|sort -k4nr|head -n ${number}
}

function persi_showCPUTopProcess()
{
    local number=$1
    if [ -z "${number}" ]; then
        number=10
    fi
    ps -ef | sort -k3nr | head -n ${number}
}

function persi_showSystemVersion()
{
    if [ -f "/etc/redhat-release" ]; then
        cat /etc/redhat-release
    elif [ -f "/etc/issue" ]; then
        cat /etc/issue
    else
        uname -a
    fi
}

function persi_tail_f_n()
{
    if [ ! -f "$1" ]; then
        showFailureMessage "File ${1} does not exists"
        return 1
    fi
    tail -n 100 -F "$1"
}

function persi_setHttpV2rayProxy()
{
    local v2rayRunning=$(netstat -an|grep -c 127.0.0.1.1087)
    if [ "$v2rayRunning" -lt 1 ]; then
        showFailureMessage "Please check the startup status of V2ray."
        return 1
    fi
    export http_proxy=http://127.0.0.1:1087
    export https_proxy=http://127.0.0.1:1087
    showSuccessMessage "Successfully set http proxy to 127.0.0.1:1087"
}

alias showSystemVersion='persi_showSystemVersion'
alias showPath='echo $PATH'
alias showMemoryTopProcess='persi_showMemoryTopProcess'
alias showCPUTopProcess='persi_showCPUTopProcess'
alias tf='persi_tail_f_n'

# Proxy
alias setHttpV2rayProxy='persi_setHttpV2rayProxy'
alias unsetHttpProxy='unset http_proxy && unset https_proxy'

# Ubuntu
function persi_ubuntu_set_mirrors()
{
    if [ ! -s '/etc/apt/sources.list' ]; then
        showFailureMessage "Current OS system not a ubuntu"
        return 1
    fi
    local mirror=$1
    if [ -z "$mirror" ]; then
        showFailureMessage "Please select the mirror to be operated"
        return 1
    fi
    local seted=0
    if [ "$mirror" = 'aliyun' ]; then
        sed -i s/archive.ubuntu.com/mirrors.aliyun.com/g /etc/apt/sources.list
        seted=1
    fi
    if [ "$mirror" = 'tencent' ]; then
        sed -i s/archive.ubuntu.com/mirrors.cloud.tencent.com/g /etc/apt/sources.list
        seted=1
    fi
    if [ $seted = 1 ]; then
        apt clean all
        apt update
    fi
}

alias ubuntuSetAptMirror='persi_ubuntu_set_mirrors'

# Python
function persi_pip_set_tencent()
{
    pip install pip -U
    pip config set global.index-url https://mirrors.cloud.tencent.com/pypi/simple
}
alias pipupgradeself='python3 -m pip install --upgrade pip'
alias pipupgrade='python3 -m pip install --upgrade'
alias pipsetmirrortencent='persi_pip_set_tencent'

# Javascript & Node
function persi_npm_set_mirrors()
{
    local mirror=$1
    if [ -z "$mirror" ]; then
        showFailureMessage "Please select the mirror to be operated, e:tencent,aliyun"
        return 1
    fi
    local seted=0
    if [ "$mirror" = 'aliyun' ]; then
        npm config set registry https://registry.npm.taobao.org/
        showSuccessMessage 'npm set mirror successfully. https://registry.npm.taobao.org'
    fi
    if [ "$mirror" = 'tencent' ]; then
        npm config set registry https://mirrors.cloud.tencent.com/npm/
        showSuccessMessage 'npm set mirror successfully. https://mirrors.cloud.tencent.com/npm'
    fi
}

alias npmSetMirror='persi_npm_set_mirrors'
alias npmUnsetMirror='npm config delete registry'

# Core dump for mac
alias coreclear="rm -rf /cores/core.*"
alias corell="ll /cores"

# Mail
# shellcheck disable=SC2139
alias mailtcz="truncate -s 0 /var/mail/${USER}"

# Docker
function persi_dockerExec()
{
    local container=$1
    local workDir=$3
    local execCommand=$2
    if [ -z ${container} ]; then
        showFailureMessage "Please select the container to be operated"
        return
    fi
    if [ -z ${workDir} ]; then
        workDir='/root/'
    fi
    if [ -z ${execCommand} ]; then
        execCommand='/bin/bash'
    fi
    docker exec -t -i -w ${workDir} ${container} ${execCommand}
}

alias dockerStartAll='docker start $(docker ps -a -q)'
alias dockerStopAll='docker stop $(docker ps -a -q)'
alias dockerRemoveAll='docker rm $(docker ps -a -q)'
alias dockerExec='persi_dockerExec'

# Drone
alias dros='persi_drone_repo_sign'

# Mac
alias macOsAppInstallSourceAll="sudo spctl --master-disable"

# Android
alias androidReboot="adb reboot"
alias androidActivityTop="adb shell dumpsys activity top |head -n 5"

# Xdebug open cli listen
alias xdebugOpen='export XDEBUG_TRIGGER=true'
alias xdebugClose='unset XDEBUG_TRIGGER'

# Log
if [ -e "/usr/local/php/var/log/php-fpm.log" ]; then
    PERSI_PHP_FPM_ERROR_LOG="/usr/local/php/var/log/php-fpm.log"
    else
    PERSI_PHP_FPM_ERROR_LOG="/usr/local/var/log/php-fpm.log"
fi

function persi_phpEditConfig()
{
    # shellcheck disable=SC2155
    local phpConfigPath=$(php --ini|grep php.ini |tail -n 1|awk '{printf $4}')

    if [ -z "${phpConfigPath}" ]; then
        showFailureMessage "php.ini not found !"
        return
    fi
    vim "${phpConfigPath}"
}

# shellcheck disable=SC2139
alias phpEditConfig='persi_phpEditConfig'
# shellcheck disable=SC2139
alias phpWatchLog="tail -n 100 -F ${PERSI_PHP_FPM_ERROR_LOG}"
# shellcheck disable=SC2139
alias phpCleanLog="truncate -s 0 ${PERSI_PHP_FPM_ERROR_LOG}"
# shellcheck disable=SC2139
alias phpEditLog="vim ${PERSI_PHP_FPM_ERROR_LOG}"
# shellcheck disable=SC2168
local PERSI_REDIS_LOG="/usr/local/var/log/redis.log"
# shellcheck disable=SC2139
alias redisWatchLog="tail -n 100 -F ${PERSI_REDIS_LOG}"
# shellcheck disable=SC2139
alias redisCleanLog="truncate -s 0 ${PERSI_REDIS_LOG}"

if [ -e "/data/wwwlogs/error_nginx.log" ]; then
    PERSI_NGINX_ERROR_LOG="/data/wwwlogs/error_nginx.log"
    else
    PERSI_NGINX_ERROR_LOG="/usr/local/var/log/nginx_error.log"
fi

# shellcheck disable=SC2139
alias nginxWatchLog="tail -n 100 -F ${PERSI_NGINX_ERROR_LOG}"
# shellcheck disable=SC2139
alias nginxCleanLog="truncate -s 0 ${PERSI_NGINX_ERROR_LOG}"
# shellcheck disable=SC2168
local MYSQL_ERROR_LOG="/usr/local/var/log/mysql_error.log"
# shellcheck disable=SC2139
alias mysqlWatchLog="tail -n 100 -F ${MYSQL_ERROR_LOG}"
# shellcheck disable=SC2139
alias mysqlCleanLog="truncate -s 0 ${MYSQL_ERROR_LOG}"

# Acme.sh
function persi_acmeRenew()
{
    local domain=$1
    if [ -z "${domain}" ]; then
        showFailureMessage "Please enter the domain name for which you want the certificate"
        return
    fi
    /root/.acme.sh/acme.sh --renew -d "${domain}" --force
}

alias acmeRenew='persi_acmeRenew'

# Systemd
alias sc-logs='journalctl -f -u'

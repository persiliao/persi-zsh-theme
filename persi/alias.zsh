# Alias
# Editor
alias -s js=vim
alias -s c=vim
alias -s java=vim
alias -s txt=vim
alias -s log=vim
# alias -s php=vim
alias -s gz='tar -xzvf'
alias -s tgz='tar -xzvf'
alias -s zip='unzip'
alias -s bz2='tar -xjvf'
# required install unrar
alias -s rar='unrar x'

function persi_lg()
{
    ls -alhF|grep -v grep |grep -i $1
}

function persi_pg()
{
    ps -ef|grep -v grep |grep -i $1
}

function persi_netpg()
{
    netstat -an|grep -v grep|grep -i $1
}

# Zsh
alias tczero="truncate -s 0"
alias ztczhistory="truncate -s 0 ~/.zsh_history"
alias ll="ls -alhF"
alias lg="persi_lg"
alias pg='persi_pg'
alias npg='persi_netpg'
alias rm="rm -ri"
# Generate rand password
alias grand="openssl rand -hex"
alias grand16="openssl rand -hex 16"
alias grand32="openssl rand -hex 32"

# Git
function persi_gacsp()
{
    local message=$1
    if [[ -z ${message} ]]; then
        showFailureMessage "Aborting commit due to empty commit message"
        return
    fi
    local branch=$(git_current_branch)
    `git add . && git commit -m "${*}" && git pull origin ${branch} && git submodule update --recursive --remote --merge && git add . && git commit -m "${*}" && git push origin ${branch}`
}

function persi_gacp()
{
    local message=$1
    if [[ -z ${message} ]]; then
        showFailureMessage "Aborting commit due to empty commit message"
        return
    fi
    local branch=$(git_current_branch)
    `git add . && git commit -m "${*}" && git pull origin ${branch} && git push origin ${branch}`
}

function persi_gacmsg()
{
    local message=$1
    if [[ -z ${message} ]]; then
        showFailureMessage "Aborting commit due to empty commit message"
        return
    fi
    `git add . && git commit -m "${*}"`
}

function persi_gcmsg()
{
    local message=$1
    if [[ -z ${message} ]]; then
        showFailureMessage "Aborting commit due to empty commit message"
        return
    fi
    `git commit -m "${*}"`
}

function persi_gitPushAll()
{
    `git remote -v|grep push|awk '{print $1}'|xargs -t -n 1 git push`
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
alias gacmsg='persi_gacmsg'
alias gacsp='persi_gacsp'
alias gacp='persi_gacp'
alias gpushall='persi_gitPushAll'

# System
function showMemoryTopProcess()
{
    local number=$1
    if [ -z ${number} ]; then
        number=10
    fi
    ps -ef|sort -k4nr|head -n ${number}
}

function showCPUTopProcess()
{
    local number=$1
    if [ -z ${number} ]; then
        number=10
    fi
    ps -ef | sort -k3nr | head -n ${number}
}

alias showMemoryTopProcess='showMemoryTopProcess'
alias showCPUTopProcess='showCPUTopProcess'

# Python
alias pipupgradeself='python3 -m pip install --upgrade pip'

# Core dump for mac
alias coreclear="rm -rf /cores/core.*"
alias corell="ll /cores"

# Mail
# shellcheck disable=SC2139
alias mailtcz="truncate -s 0 /var/mail/${USER}"

# Composer
alias crnodev="composer require --no-dev"
alias cunodev="composer update --no-dev"
alias cinodev="composer install --no-dev"
alias crb='./bin/satis build ./satis.json ./build'

# Hyperf
alias hyperf="./bin/hyperf.php 2>/dev/null"
alias hyperfStart="./bin/hyperf.php start 2>/dev/null"
# shellcheck disable=SC2142
alias hyperfStop="lsof -i:9501|tail -n 1|awk '{print \$2}'|xargs kill -15 2>/dev/null"
# shellcheck disable=SC2142
alias hyperfRestart="lsof -i:9501|tail -n 1|awk '{print \$2}'|xargs kill -15 && ./bin/hyperf.php start 2>/dev/null"
alias hyperfOverrideProxy="./vendor/bin/init-proxy.sh 2>/dev/null"
# shellcheck disable=SC2142
alias hyperfOverrideProxyRestart="./vendor/bin/init-proxy.sh 2>/dev/null && lsof -i:9501|tail -n 1|awk '{print \$2}'|xargs kill -15 && ./bin/hyperf.php start 2>/dev/null"
alias hyperfDescribeRoutes="./bin/hyperf.php describe:routes 2>/dev/null"
alias hyperfProcessInfo="lsof -i:9501"
# shellcheck disable=SC2142
alias hyperfMacStopAll="ps -ef|grep -v grep|grep hyperf.php|awk '{print \$2}'|xargs kill -9 2>/dev/null"

# Hyperf Generator
alias hyperfGenCommand="./bin/hyperf.php gen:command"
alias hyperfGenController="./bin/hyperf.php gen:controller"
alias hyperfGenListener="./bin/hyperf.php gen:listener"
alias hyperfGenModel="./bin/hyperf.php gen:model"
alias hyperfGenMiddleware="./bin/hyperf.php gen:middleware"
alias hyperfGenMigration="./bin/hyperf.php gen:migration"
alias hyperfGenRequest="./bin/hyperf.php gen:request"
alias hyperfGenAspect="./bin/hyperf.php gen:aspect"
alias hyperfGenJob="./bin/hyperf.php gen:job"
alias hyperfGenSeeder="./bin/hyperf.php gen:seeder"
alias hyperfGenProcess="./bin/hyperf.php gen:process"

alias hyperfVendorPublish="./bin/hyperf.php vendor:publish"

# Docker
function dockerExec()
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
    docker exec -ti -w ${workDir} ${container} ${execCommand}
}

alias dockerStartAll='docker start $(docker ps -a -q)'
alias dockerStopAll='docker stop $(docker ps -a -q)'
alias dockerRemoveAll='docker rm $(docker ps -a -q)'
alias dockerExec='dockerExec'

# Drone
alias dros='persi_drone_repo_sign'

# Mac
alias macOsAppInstallSourceAll="sudo spctl --master-disable"
alias ipshow="ifconfig en0 |grep inet"

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

function phpEditConfig()
{
    local phpConfigPath=$(php --ini|grep php.ini |tail -n 1|awk '{printf $4}')
    if [ -z $phpConfigPath ]; then
        showFailureMessage "php.ini not found !"
        return
    fi
    `vim ${phpConfigPath}`
}

# shellcheck disable=SC2139
alias phpEditConfig='phpEditConfig'
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


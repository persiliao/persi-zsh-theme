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
# Zsh
alias tczero="truncate -s 0"
alias zchistory="truncate -s 0 ~/.zsh_history"
alias ll="ls -alhF"
alias lg="ls -alhF|grep -v grep |grep -i"
alias pg="pstree|grep -v grep |grep -i"
alias rm="rm -ri"
# Generate rand password
alias grand="openssl rand -hex"
alias grand16="openssl rand -hex 16"
alias grand32="openssl rand -hex 32"

# Git
alias gacmsg='git add . && git commit -m'
alias gacp='git add . && git commit -m "update" && git pull origin $(git_current_branch) && git push origin $(git_current_branch)'
alias gmm='git merge master'
alias gmd='git merge develop'
alias ggpushmaster='git push origin $(git_main_branch)'
alias gsa='git submodule add '
alias gsui='git submodule update --init --recursive'
alias gsurm='git submodule update --recursive --remote --merge'

# Clean
if [ `/usr/bin/uname` = "Darwin" ]; then
    alias deleteAllSpace="sed -i \"\" '/^\s*$/d'"
else
    alias deleteAllSpace="sed -i '/^\s*$/d'"
fi

# Core dump
alias coreclear="rm -rf /cores/core.*"
alias corell="ll /cores"

# Mail
alias mailtcz="truncate -s 0 /var/mail/${USER}"

# Hyperf
alias hyperf="./bin/hyperf.php 2>/dev/null"
alias hyperfStart="./bin/hyperf.php start 2>/dev/null"
alias hyperfStop="lsof -i:9501|tail -n 1|awk '{print \$2}'|xargs kill -15 2>/dev/null"
alias hyperfRestart="lsof -i:9501|tail -n 1|awk '{print \$2}'|xargs kill -15 && ./bin/hyperf.php start 2>/dev/null"
alias hyperfOverrideProxy="./vendor/bin/init-proxy.sh 2>/dev/null"
alias hyperfOverrideProxyRestart="./vendor/bin/init-proxy.sh 2>/dev/null && lsof -i:9501|tail -n 1|awk '{print \$2}'|xargs kill -15 && ./bin/hyperf.php start 2>/dev/null"
alias hyperfDescribeRoutes="./bin/hyperf.php describe:routes 2>/dev/null"
alias hyperfProcessInfo="lsof -i:9501"
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
alias dockerStopAll='docker stop $(docker ps -a -q)'
alias dockerRemoveAll='docker rm $(docker ps -a -q)'

# Mac
alias macOsAppInstallSourceAll="sudo spctl --master-disable"
alias ipshow="ifconfig en0 |grep inet"

# Android
alias androidReboot="adb reboot"
alias androidActivityTop="adb shell dumpsys activity top |head -n 5"

# Log
if [ -e "/usr/local/php/var/log/php-fpm.log" ]; then
    PHP_FPM_ERROR_LOG="/usr/local/php/var/log/php-fpm.log"
    else
    PHP_FPM_ERROR_LOG="/usr/local/var/log/php-fpm.log"
fi

alias phpWatchLog="sudo tail -n 100 -F ${PHP_FPM_ERROR_LOG}"
alias phpCleanLog="sudo truncate -s 0 ${PHP_FPM_ERROR_LOG}"
alias phpEditLog="sudo vim ${PHP_FPM_ERROR_LOG}"
local REDIS_LOG="/usr/local/var/log/redis.log"
alias redisWatchLog="sudo tail -n 100 -F ${REDIS_LOG}"
alias redisCleanLog="sudo truncate -s 0 ${REDIS_LOG}"

if [ -e "/data/wwwlogs/error_nginx.log" ]; then
    NGINX_ERROR_LOG="/data/wwwlogs/error_nginx.log"
    else
    NGINX_ERROR_LOG="/usr/local/var/log/nginx_error.log"
fi

alias nginxWatchLog="sudo tail -n 100 -F ${NGINX_ERROR_LOG}"
alias nginxCleanLog="sudo truncate -s 0 ${NGINX_ERROR_LOG}"
local MYSQL_ERROR_LOG="/usr/local/var/log/mysql_error.log"
alias mysqlWatchLog="sudo tail -n 100 -F ${MYSQL_ERROR_LOG}"
alias mysqlCleanLog="sudo truncate -s 0 ${MYSQL_ERROR_LOG}"


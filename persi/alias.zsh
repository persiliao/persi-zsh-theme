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

alias week="php -r \"echo date('W') . PHP_EOL;\""
alias ipshow="ifconfig en0"

alias makeRandomPasswd="md5 -s $(date "+%Y%m%d%H:%M:%S")"
# Zsh
alias zshReloadConfig="source ~/.zshrc"
alias zshClearHistory='echo "" > ~/.zsh_history & exec $SHELL -l'
alias zshEditConfig="sublime ~/.zshrc"
alias ohmyzshEdit="sublime ~/.oh-my-zsh"
alias ll="ls -alhF"
alias lg="ls -alhF|grep -v grep |grep -i "
alias pg="pstree|grep -v grep |grep -i "
alias rm="rm -ri"

# Git
alias gac="git add . && git commit -m "
alias gacp="git add . && git commit -m "update" && git push"

# App compile
alias makeinstall="make -j8 && make install"

# Core dump
alias coreclear="rm -rf /cores/core.*"
alias corell="ll /cores"

# Mail
alias mailtruncate="truncate -s 0 /var/mail/${USER}"

# WorkerSpace
PersiLiaoWorkerDirectory="/Volumes/Documents/WorkSpace/Wepartner/OppoGlobalDesignActivity"
alias cdWorkerDirectory="cd ${PersiLiaoWorkerDirectory}"
alias cdWorkspace="cd /Volumes/Documents/WorkSpace"
# Magento2
alias mgto2CodeSniffer="phpcs --standard=/Users/persi/WorkSpace/MagentoCode/vendor/magento-ecg/coding-standard/EcgM2 "
alias mgto2ModuleUpdateDeploy='bin/magento setup:upgrade
bin/magento setup:di:compile
bin/magento setup:static-content:deploy -f
bin/magento cache:clean'

# PHP
PHP_DEVELOPMENT_WORK_DIR="/Volumes/Documents/WorkSpace/Php/php-7.4.3"
alias phpdev="${PHP_DEVELOPMENT_WORK_DIR}/bin/php"
alias cdphpdev="cd ${PHP_DEVELOPMENT_WORK_DIR}"
alias extDevelopmentComplie="${PHP_DEVELOPMENT_WORK_DIR}/phpize && ./configure --with-php-config=${PHP_DEVELOPMENT_WORK_DIR}/php-config && make -j4 && make install"

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

# Andorid
alias classyShark="java -jar /Users/persi/Downloads/Android/JavaDecompiler/ClassyShark.jar"

# OpenCart
alias ocCleanCached="rm -rf /Documents/WorkSpace/OpenCartStorage/cache"

# Mac
alias macOsAppInstallSourceAll="sudo spctl --master-disable"

# Android
alias androidReboot="adb reboot"
alias androidUninstallWeChatNew="adb shell pm uninstall -k com.tencent.mm"
alias androidInstallWeChat667="adb install /Users/persi/Downloads/Android/Wechat/WeChat667.apk"
alias androidActivityTop="adb shell dumpsys activity top |head -n 5"
alias androidWeChatStart="adb shell am start com.tencent.mm/com.tencent.mm.ui.LauncherUI"
alias androidWeChatStop="adb shell am force-stop com.tencent.mm"
alias androidXposedMarketStart="adb shell am start com.marketing.wechat.persiliao.wechatmarketing/com.marketing.wechat.persiliao.wechatmarketing.MainActivity"
alias androidXposedMarketStop="adb shell am force-stop com.marketing.wechat.persiliao.wechatmarketing"


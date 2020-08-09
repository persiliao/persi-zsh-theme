# System Setting

setopt AUTO_LIST
setopt AUTO_MENU
setopt localoptions rmstarsilent
setopt histignorespace
unsetopt share_history
unsetopt correct_all

# ulimit -c unlimited
ulimit -c 0
umask 002

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Brew 
## Turn off automatic updates every time Brew executes a command
export HOMEBREW_NO_AUTO_UPDATE=true
## Tsinghua mirror source
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"


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
## 关闭brew每次执行命令时的自动更新
export HOMEBREW_NO_AUTO_UPDATE=true
## 清华镜像源
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"

# Golang
export GOROOT="/usr/local/opt/go/libexec"
export GOPATH="/Volumes/Documents/WorkSpace/Golang"


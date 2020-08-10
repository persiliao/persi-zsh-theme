#!/bin/zsh
#
# Deploy Zsh Custom

workDirectory=$(dirname "$0")
pushd ${workDirectory} > /dev/null
workDirectory=$(pwd)

source ~/.zshrc

if [ `/usr/bin/uname` = "Darwin" ]; then
    sed -i "" 's/\(ZSH_THEME\).*/\1="persi"/g' ~/.zshrc
else
    sed -i 's/\(ZSH_THEME\).*/\1="persi"/g' ~/.zshrc
fi

ZSH_CUSTOM_THEME="${ZSH_CUSTOM}/themes"

cp -R "${workDirectory}/persi" "${ZSH_CUSTOM_THEME}"
cp "${workDirectory}/persi.zsh-theme" "${ZSH_CUSTOM_THEME}/persi.zsh-theme"

source ~/.zshrc

echo "persi.zsh-theme deploy success."

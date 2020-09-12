#!/bin/zsh
#
# Deploy persi zsh custom theme

workDirectory=$(dirname "$0")
# shellcheck disable=SC2164
pushd ${workDirectory} > /dev/null
workDirectory=$(pwd)

# shellcheck disable=SC1090
source ~/.zshrc

# shellcheck disable=SC2046
if [ `/usr/bin/uname` = "Darwin" ]; then
    sed -i "" 's/\(ZSH_THEME\).*/\1="persi"/g' ~/.zshrc
else
    sed -i 's/\(ZSH_THEME\).*/\1="persi"/g' ~/.zshrc
fi

ZSH_CUSTOM_THEME="${ZSH_CUSTOM}/themes"

cp -R "${workDirectory}/persi" "${ZSH_CUSTOM_THEME}"
cp "${workDirectory}/persi.zsh-theme" "${ZSH_CUSTOM_THEME}/persi.zsh-theme"

echo -e "${CLISTART}${CLIDGREEN}🍺 persi.zsh-theme deploy success.${CLIEND}"

#!/bin/zsh
#
# Deploy persi zsh custom theme

workDirectory=$(dirname "$0")
# shellcheck disable=SC2164
pushd ${workDirectory} > /dev/null
workDirectory=$(pwd)
# shellcheck disable=SC1090
source ~/.zshrc

ZSH_CUSTOM_THEME="${ZSH_CUSTOM}/themes"

_useConfigAndAlias(){
    read -q "UseConfigAndAlias?Whether to use the recommended config and alias [y/n] ? "
    if [[ $UseConfigAndAlias == 'y' ]]; then
        cp -R "${workDirectory}/persi" "${ZSH_CUSTOM_THEME}"
        echo -e "\n${CLISTART}${CLIDGREEN}🍺 cp config to ${ZSH_CUSTOM_THEME} ${CLIEND}"
    else
        echo -e "\n"
    fi
}

cp "${workDirectory}/persi.zsh-theme" "${ZSH_CUSTOM_THEME}/persi.zsh-theme"

# shellcheck disable=SC2046
if [ `/usr/bin/uname` = "Darwin" ]; then
    sed -i "" 's/\(ZSH_THEME\).*/\1="persi"/g' ~/.zshrc
else
    sed -i 's/\(ZSH_THEME\).*/\1="persi"/g' ~/.zshrc
fi

_useConfigAndAlias

source ~/.zshrc

echo -e "${CLISTART}${CLIDGREEN}🍺 persi.zsh-theme command Installed successfully.${CLIEND}"

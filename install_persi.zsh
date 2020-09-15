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

_useRecommendedPlugin(){
    echo
    read -q "UsedRecommended?Whether to use the recommended plug-in (zsh_reload wd git gitignore git-flow docker npm node golang wp-cli composer yarn ) [y/n]? "
    if [[ $UsedRecommended == 'y' ]]; then
        RecommendedPlugin="zsh_reload wd git gitignore git-flow docker npm node golang wp-cli composer yarn "
        # shellcheck disable=SC2046
        if [ `/usr/bin/uname` = "Darwin" ]; then
            sed -i "" "s/\(^plugins=(\)\s*/\1${RecommendedPlugin}/" ~/.zshrc
        else
            sed -i "s/\(^plugins=(\)\s*/\1${RecommendedPlugin}/" ~/.zshrc
        fi
        echo -e "\n${CLISTART}${CLIDGREEN}🍺 plugin added ${RecommendedPlugin}${CLIEND}"
    fi
}

_useConfigAndAlias(){
    echo 
    read -q "UseConfigAndAlias?Whether to use the recommended config and alias [y/n]? "
    if [[ $UseConfigAndAlias == 'y' ]]; then
        cp -R "${workDirectory}/persi" "${ZSH_CUSTOM_THEME}"
        echo -e "\n${CLISTART}${CLIDGREEN}🍺 cp config to ${ZSH_CUSTOM_THEME} ${CLIEND}"    
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

_useRecommendedPlugin

echo -e "${CLISTART}${CLIDGREEN}🍺 persi.zsh-theme Installed successfully.${CLIEND}"

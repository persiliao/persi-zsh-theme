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
    read -q "UsedRecommended?Whether to use the recommended plug-in (zsh_reload wd git gitignore git-flow git-flow-avh docker npm node golang wp-cli composer yarn systemd systemadmin ) [y/n] ? "
    if [[ $UsedRecommended == 'y' ]]; then
        RecommendedPlugin="zsh_reload wd git gitignore git-flow git-flow-avh docker npm node golang wp-cli composer yarn systemd systemadmin "
        # shellcheck disable=SC2046
        if [ `/usr/bin/uname` = "Darwin" ]; then
            sed -i "" "s/\(^plugins=(\)\s*/\1${RecommendedPlugin}/" ~/.zshrc
        else
            sed -i "s/\(^plugins=(\)\s*/\1${RecommendedPlugin}/" ~/.zshrc
        fi
        echo -e "\n${CLISTART}${CLIDGREEN}🍺 plugin added ${RecommendedPlugin}${CLIEND}"
    else
        echo -e "\n"
    fi
}

_useConfigAndAlias(){
    read -q "UseConfigAndAlias?Whether to use the recommended config and alias [y/n] ? "
    if [[ $UseConfigAndAlias == 'y' ]]; then
        cp -R "${workDirectory}/persi" "${ZSH_CUSTOM_THEME}"
        echo -e "\n${CLISTART}${CLIDGREEN}🍺 cp config to ${ZSH_CUSTOM_THEME} ${CLIEND}" 
    else
        echo -e "\n"   
    fi
}

_useTsinghuaHomebrew(){
    read -q "UseTsinghuaHomebrew?Whether to use Homebrew Tsinghua mirror source [y/n] ? "
    if [[ $UseTsinghuaHomebrew == 'y' ]]; then
        echo 'export HOMEBREW_CORE_GIT_REMOTE=https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git' >> ~/.zshrc
        echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles' >> ~/.zshrc
        echo -e "\n${CLISTART}${CLIDGREEN}🍺 homebrew use tsinghua mirror ${CLIEND}"
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

_useRecommendedPlugin
_useTsinghuaHomebrew
_useConfigAndAlias

echo -e "${CLISTART}${CLIDGREEN}🍺 persi.zsh-theme Installed successfully.${CLIEND}"

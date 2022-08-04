persi_check_sed_is_gnu(){
    # shellcheck disable=SC2155
    local IS_GNU=`sed --version | grep GNU | wc -l`
    # shellcheck disable=SC2166
    if [ $? = 0 -a $IS_GNU -gt 0 ]; then
        export PERSI_SED_IS_GNU="1"
    fi
    export PERSI_SED_IS_GNU="1"
}

persi_reload_zsh(){
    # shellcheck disable=SC1090
    source ~/.zshrc
}

persi_set_zsh_custom_dir(){
    persi_reload_zsh
    export PERSI_ZSH_CUSTOM_THEME_DIR="${ZSH_CUSTOM}/themes"
}

persi_get_repo_name(){
    # shellcheck disable=SC2155
    export PERSI_GIT_REPO_NAME=`git remote -v | grep -v grep |grep -i origin | head -n 1 | awk '{print $2}' | sed 's#^https://\([^/]*\)/\([^\.]*\)#\2#g'`
    PERSI_GIT_REPO_NAME=${PERSI_GIT_REPO_NAME%.git}
    if [[ -z $PERSI_GIT_REPO_NAME ]]; then
        echo -e "${CLISTART}${CLIRED}not a git repository (or any of the parent directories): .git${CLIEND}"
        return 1
    fi
    echo -e "Repo Name: ${CLISTART}${CLIDGREEN}${PERSI_GIT_REPO_NAME}${CLIEND}"
    return 0
}

persi_activate_zsh_theme(){
    # shellcheck disable=SC2046
    persi_check_sed_is_gnu
    if [ $PERSI_SED_IS_GNU = "1" ]; then
        sed -i 's/\(ZSH_THEME\).*/\1="persi"/g' ~/.zshrc
        else
        sed -i "" 's/\(ZSH_THEME\).*/\1="persi"/g' ~/.zshrc
    fi
}

persi_deploy_zsh_theme(){
    cp "${PERSI_THEME_WORK_DIRECTORY}/persi.zsh-theme" "${PERSI_ZSH_CUSTOM_THEME_DIR}/persi.zsh-theme"
}

persi_install_zsh_theme(){
    persi_deploy_zsh_theme
    read -q "PERSI_ACTIVATE_ZSH_THEME?Whether to activate persi.zsh-theme [y/n]: "
    if [ $PERSI_ACTIVATE_ZSH_THEME = 'y' ]; then
        persi_activate_zsh_theme
    fi
}

persi_install_command(){
    read -q "PERSI_INSTALL_COMMAND?Whether to use the recommended alias command [y/n]: "
    if [ $PERSI_INSTALL_COMMAND = 'y' ]; then
        cp -R "${PERSI_THEME_WORK_DIRECTORY}/persi" "${PERSI_ZSH_CUSTOM_THEME_DIR}"
        echo -e "\n${CLISTART}${CLIDGREEN}🍺 cp alias command to ${PERSI_ZSH_CUSTOM_THEME_DIR} ${CLIEND}"
        return 0
    else
        echo -e "\n"
        return 1
    fi
}

persi_install_plugin(){
    read -q "PERSI_INSTALL_PLUGIN?Whether to use the recommended plugins [y/n]: "
    if [ $PERSI_INSTALL_PLUGIN = 'y' ]; then
        PERSI_ZSH_RECOMMENDED_PLUGIN=(wd git gitignore git-flow git-flow-avh docker docker-compose kubectl npm node  golang wp-cli composer yarn systemd systemadmin mvn nvm pip redis-cli supervisor gradle)
        PERSI_ZSH_PLUGINS=$(cat ~/.zshrc|grep '^plugins')
        PERSI_ZSH_PLUGINS=${PERSI_ZSH_PLUGINS:9:${#PERSI_ZSH_PLUGINS}-10}
        for plugin in $PERSI_ZSH_PLUGINS
        do
            PERSI_PLUGINS=$(echo ${PERSI_ZSH_RECOMMENDED_PLUGIN[*]} | sed 's/\<'$plugin'\>//')
            unset PERSI_ZSH_RECOMMENDED_PLUGIN
            PERSI_ZSH_RECOMMENDED_PLUGIN=${PERSI_PLUGINS[@]}
        done
        # shellcheck disable=SC2046
        persi_check_sed_is_gnu
        if [ $PERSI_SED_IS_GNU = "1" ]; then
            sed -i "s/\(^plugins=(\)\s*/\1${PERSI_ZSH_RECOMMENDED_PLUGIN[*]} /" ~/.zshrc
        else
            sed -i "" "s/\(^plugins=(\)\s*/\1${PERSI_ZSH_RECOMMENDED_PLUGIN[*]} /" ~/.zshrc
        fi
        echo -e "\n${CLISTART}${CLIDGREEN}🍺 plugin added ${PERSI_ZSH_RECOMMENDED_PLUGIN[*]}${CLIEND}"
    fi
}

persi_set_homebrew_remote_tsinghua(){
    read -q "PERSI_SET_HOMEBREW_REMOTE?Whether to use Homebrew Tsinghua mirror source [y/n]: "
    if [ $PERSI_SET_HOMEBREW_REMOTE = 'y' ]; then
        # shellcheck disable=SC2092
        `git -C "$(brew --repo)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git`
        BREW_TAPS="$(brew tap)"
        for tap in core cask{,-fonts,-drivers,-versions}; do
            if echo "$BREW_TAPS" | grep -qE "^homebrew/${tap}\$"; then
                git -C "$(brew --repo homebrew/${tap})" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-${tap}.git
                git -C "$(brew --repo homebrew/${tap})" config homebrew.forceautoupdate true
            else
                brew tap --force-auto-update homebrew/${tap} https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-${tap}.git
            fi
        done
        STEP=`brew update-reset`
        echo $STEP
        echo -e "\n${CLISTART}${CLIDGREEN}🍺 homebrew use tsinghua mirror ${CLIEND}"
    fi
}

persi_set_homebrew_remote_github(){
    read -q "PERSI_SET_HOMEBREW_REMOTE?Whether to use Homebrew Github mirror source [y/n]: "
    if [ $PERSI_SET_HOMEBREW_REMOTE = 'y' ]; then
        # shellcheck disable=SC2092
        `git -C "$(brew --repo)" remote set-url origin https://github.com/Homebrew/brew.git`
        BREW_TAPS="$(brew tap)"
        for tap in core cask{,-fonts,-drivers,-versions}; do
            if echo "$BREW_TAPS" | grep -qE "^homebrew/${tap}\$"; then
                git -C "$(brew --repo homebrew/${tap})" remote set-url origin https://github.com/Homebrew/homebrew-${tap}.git
            fi
        done
        STEP=`brew update-reset`
        echo $STEP
        echo -e "\n${CLISTART}${CLIDGREEN}🍺 homebrew use github mirror ${CLIEND}"
    fi
}

persi_drone_check_server(){
    # shellcheck disable=SC2166
    if [ ! $DRONE_SERVER -o ! $DRONE_TOKEN ]; then
        echo -e "${CLISTART}${CLIRED} you must provide the Drone server address. ${CLIEND}"
        return 1
    fi
    echo -e "Drone Server: ${CLISTART}${CLIDGREEN}$DRONE_SERVER${CLIEND}"
    return 0
}

persi_drone_repo_enable(){
    persi_drone_check_server
    if [ $? -ne 0 ]; then
        return 1
    fi
    persi_get_repo_name
    if [ $? -ne 0 ]; then
        return 1
    fi
    read -q "PERSI_DRONE_ENABLE?Whether to enable the current repository to ${DRONE_SERVER} [y/n]: "
    if [ $PERSI_DRONE_ENABLE = 'y' ]; then
        # shellcheck disable=SC2092
        `drone repo enable ${PERSI_GIT_REPO_NAME}`
        if [ $? = 0 ]; then
            echo -e "${CLISTART}${CLIDGREEN}🍺 Drone enable successfully, Repo Name: ${PERSI_GIT_REPO_NAME} to ${DRONE_SERVER}successfully.${CLIEND}"
        fi
    fi
    echo -e "\n"
    return 0
}

persi_drone_repo_update_protected(){
    persi_drone_check_server
    if [ $? -ne 0 ]; then
        return 1
    fi
    persi_get_repo_name
    if [ $? -ne 0 ]; then
        return 1
    fi
    read -q "PERSI_DRONE_UPDATE_PROTECTED?Whether to set current repository protected to ${DRONE_SERVER} [y/n]: "
    if [ $PERSI_DRONE_UPDATE_PROTECTED = 'y' ]; then
        # shellcheck disable=SC2092
        `drone repo update --protected ${PERSI_GIT_REPO_NAME}`
        if [ $? = 0 ]; then
            echo -e "${CLISTART}${CLIDGREEN}🍺 Drone update to protected successfully, Repo Name: ${PERSI_GIT_REPO_NAME} to ${DRONE_SERVER} successfully.${CLIEND}"
        fi
    fi
    echo -e "\n"
    return 0
}

persi_drone_repo_set_config(){
    persi_drone_check_server
    if [ $? -ne 0 ]; then
        return 1
    fi
    persi_get_repo_name
    if [ $? -ne 0 ]; then
        return 1
    fi
    if [ ! $1 ]; then
        # shellcheck disable=SC2070
        if [ -n $DRONE_DEFAULT_CONFIG ]; then
            PERSI_DRONE_CONFIG=$DRONE_DEFAULT_CONFIG
            else
            PERSI_DRONE_CONFIG='.drone.yml'
        fi
    else
        PERSI_DRONE_CONFIG=$1
    fi
    read -q "PERSI_DRONE_REPO_SET_CONFIG?Whether set the current repository drone config ${PERSI_DRONE_CONFIG} [y/n]: "
    if [ $PERSI_DRONE_REPO_SET_CONFIG = 'y' ]; then
        # shellcheck disable=SC2092
        `drone repo update --config ${PERSI_DRONE_CONFIG} ${PERSI_GIT_REPO_NAME}`
        if [ $? = 0 ]; then
            echo -e "${CLISTART}${CLIDGREEN}🍺 Drone config set successfully, Repo Name: ${PERSI_GIT_REPO_NAME} to ${PERSI_DRONE_CONFIG} successfully.${CLIEND}"
        fi
    fi
    echo -e "\n"
    return 0
}

persi_drone_repo_sign(){
    persi_drone_check_server
    if [ $? -ne 0 ]; then
        return 1
    fi
    persi_get_repo_name
    if [ $? -ne 0 ]; then
        return 1
    fi
    PERSI_DRONE_REPO_CONFIG=`drone repo info ${PERSI_GIT_REPO_NAME}|grep Config|awk '{print $2}'`
    if [ -z $PERSI_DRONE_REPO_CONFIG ]; then
        PERSI_DRONE_REPO_CONFIG='.drone.yml'
    fi
    read -q "PERSI_DRONE_SIGN?Whether to sign the current repository to ${PERSI_DRONE_REPO_CONFIG} [y/n]: "
    if [ $PERSI_DRONE_SIGN = 'y' ]; then
        # shellcheck disable=SC2092
        `drone sign --save ${PERSI_GIT_REPO_NAME} ${PERSI_DRONE_REPO_CONFIG}`
        if [ $? = 0 ]; then
            echo -e "\n${CLISTART}${CLIDGREEN}🍺 Drone sign successfully, Repo Name: ${PERSI_GIT_REPO_NAME} to ${PERSI_DRONE_REPO_CONFIG} successfully.${CLIEND}"
        fi
    fi
    return 0
}

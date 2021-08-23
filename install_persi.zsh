#!/bin/zsh

#Author: Persi.Liao(xiangchu.liao@gmail.com)
#Home: https://github.com/persiliao/persi-zsh-theme
#Description: Install persi.zsh-theme
#Version: 1.0.0

PERSI_THEME_WORK_DIRECTORY=$(dirname "$0")
# shellcheck disable=SC2164
pushd ${PERSI_THEME_WORK_DIRECTORY} > /dev/null
export PERSI_THEME_WORK_DIRECTORY=$(pwd)
# shellcheck disable=SC1090
for config_file (${PERSI_THEME_WORK_DIRECTORY}/persi/*.zsh); do
    if [ -f "${config_file}" ]; then
        source $config_file
    fi
done

persi_set_zsh_custom_dir

persi_install_command

persi_install_plugin

persi_install_zsh_theme

echo -e "${CLISTART}${CLIDGREEN}🍺 persi.zsh-theme installed successfully.${CLIEND}"

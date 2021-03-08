#!/bin/zsh
#
# Deploy persi zsh custom theme

PERSI_THEME_WORK_DIRECTORY=$(dirname "$0")
# shellcheck disable=SC2164
pushd ${PERSI_THEME_WORK_DIRECTORY} > /dev/null
export PERSI_THEME_WORK_DIRECTORY=$(pwd)

for config_file ($PERSI_THEME_WORK_DIRECTORY/persi/*.zsh); do
    if [ -f "${config_file}" ]; then
        source $config_file
    fi
done

persi_set_zsh_custom_dir

persi_install_command

persi_install_plugin

persi_set_homebrew_remote_tsinghua

persi_install_zsh_theme

persi_reload_zsh

echo -e "\n${CLISTART}${CLIDGREEN}🍺 persi.zsh-theme Installed successfully.${CLIEND}"

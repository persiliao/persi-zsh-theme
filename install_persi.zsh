#!/usr/bin/env zsh

#Author: Persi.Liao(xiangchu.liao@gmail.com)
#Home: https://github.com/persiliao/persi-zsh-theme
#Description: Install persi.zsh-theme
#Version: 1.0.0

set -e

cd "$(dirname "$0")" || {
  fmt_error "You do not have permission to do this."
  exit 1;
}

PERSI_THEME_DIRECTORY="$(pwd)"
. "${PERSI_THEME_DIRECTORY}/include/functions.sh"

check_ohmyzsh() {
  if ! [ -d "${HOME}/.oh-my-zsh" ]; then
    fmt_error "Please install ohmyzsh first, see: https://github.com/ohmyzsh/ohmyzsh"
    exit 1
  fi
}

setup_install_persi_zsh_theme() {
  fmt_tips "Do you want to activate persi.zsh-theme? [Y/n] "
  read -r opt
  case $opt in
  Y*|y*|"") ;;
  N*|n*) fmt_notice "activate persi.zsh-theme skipped."; return ;;
  *) fmt_notice "Invalid choice. activate persi.zsh-theme skipped."; return ;;
  esac

  cp "${PERSI_THEME_DIRECTORY}/persi.zsh-theme" "${HOME}/.oh-my-zsh/custom/themes/persi.zsh-theme"
  if persi_check_sed_is_gnu; then
    sed -i 's/\(^ZSH_THEME\).*/\1="persi"/g' ~/.zshrc
  else
    sed -i "" 's/\(^ZSH_THEME\).*/\1="persi"/g' ~/.zshrc
  fi

  fmt_information "🍺 persi.zsh-theme installed successfully."
}

setup_install_recommended_plugin() {
  PERSI_ZSH_RECOMMENDED_PLUGINS=(wd git gitignore git-flow git-flow-avh docker docker-compose npm node golang wp-cli composer yarn systemd systemadmin mvn nvm pip redis-cli supervisor gradle)
  # shellcheck disable=SC2128
  fmt_tips "Do you want to use the recommended plugins (Default: ${PERSI_ZSH_RECOMMENDED_PLUGINS})? [Y/n] "
  read -r opt
  case $opt in
  Y*|y*|"") ;;
  N*|n*) fmt_notice "use the recommended plugins skipped."; return ;;
  *) fmt_notice "Invalid choice. use the recommended plugins skipped."; return ;;
  esac

  PERSI_ZSH_PLUGINS=$(grep "^plugins=" "${HOME}/.zshrc")
  for plugin in "${PERSI_ZSH_RECOMMENDED_PLUGINS[@]}"; do
    if ! echo "${PERSI_ZSH_PLUGINS}" | grep -b -o -c "${plugin}" > /dev/null; then
      if persi_check_sed_is_gnu; then
        sed -i "s/^plugins=(/plugins=(${plugin} /" ~/.zshrc
      else
        sed -i "" "s/^plugins=(/plugins=(${plugin} /" ~/.zshrc
      fi
    fi
  done

  fmt_information "🍺 Plugins installed successfully."
  fmt_information "Current activate plugins:"
  fmt_information "$(grep "^plugins=" "${HOME}/.zshrc")"
}

main() {
  setup_color
  check_ohmyzsh
  setup_install_persi_zsh_theme
  setup_install_recommended_plugin
}

main "${@}"

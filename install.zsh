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

# The [ -t 1 ] check only works when the function is not called from
# a subshell (like in `$(...)` or `(...)`, so this hack redefines the
# function at the top level to always return false when stdout is not
# a tty.
if [ -t 1 ]; then
  is_tty() {
    true
  }
else
  is_tty() {
    false
  }
fi

# Adapted from code and information by Anton Kochkov (@XVilka)
# Source: https://gist.github.com/XVilka/8346728
supports_truecolor() {
  case "$COLORTERM" in
  truecolor|24bit) return 0 ;;
  esac

  case "$TERM" in
  iterm           |\
  tmux-truecolor  |\
  linux-truecolor |\
  xterm-truecolor |\
  screen-truecolor) return 0 ;;
  esac

  return 1
}

setup_color() {
  # Only use colors if connected to a terminal
  if ! is_tty; then
    FMT_RAINBOW=""
    FMT_RED=""
    FMT_GREEN=""
    FMT_YELLOW=""
    FMT_BLUE=""
    FMT_BOLD=""
    FMT_RESET=""
    return
  fi

  if supports_truecolor; then
    FMT_RAINBOW="
      $(printf '\033[38;2;255;0;0m')
      $(printf '\033[38;2;255;97;0m')
      $(printf '\033[38;2;247;255;0m')
      $(printf '\033[38;2;0;255;30m')
      $(printf '\033[38;2;77;0;255m')
      $(printf '\033[38;2;168;0;255m')
      $(printf '\033[38;2;245;0;172m')
    "
  else
    # shellcheck disable=SC2034
    FMT_RAINBOW="
      $(printf '\033[38;5;196m')
      $(printf '\033[38;5;202m')
      $(printf '\033[38;5;226m')
      $(printf '\033[38;5;082m')
      $(printf '\033[38;5;021m')
      $(printf '\033[38;5;093m')
      $(printf '\033[38;5;163m')
    "
  fi

  FMT_RED=$(printf '\033[31m')
  FMT_GREEN=$(printf '\033[32m')
  FMT_YELLOW=$(printf '\033[33m')
  FMT_BLUE=$(printf '\033[34m')
  FMT_BOLD=$(printf '\033[1m')
  FMT_RESET=$(printf '\033[0m')
}

fmt_error() {
  printf '%sError: %s%s\n' "${FMT_BOLD}${FMT_RED}" "$*" "$FMT_RESET" >&2
}

fmt_notice() {
  printf '%sNotice: %s%s\n' "${FMT_BOLD}${FMT_BLUE}" "$*" "$FMT_RESET" >&2
}

fmt_information() {
  printf '%s%s%s\n' "${FMT_BOLD}${FMT_GREEN}" "$*" "$FMT_RESET" >&2
}

fmt_tips() {
  printf '%s%s%s' "${FMT_BOLD}${FMT_YELLOW}" "$*" "$FMT_RESET" >&2
}

check_ohmyzsh() {
  if ! [ -d "${HOME}/.oh-my-zsh" ]; then
    fmt_error "Please install ohmyzsh first, see: https://github.com/ohmyzsh/ohmyzsh"
    exit 1
  fi
}

check_sed_is_gnu() {
  if sed --version | head -1 | grep -q -c GNU ; then
    return 0
  else
    return 1
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
  if check_sed_is_gnu; then
    sed -i 's/\(^ZSH_THEME\).*/\1="persi"/g' ~/.zshrc
  else
    sed -i "" 's/\(^ZSH_THEME\).*/\1="persi"/g' ~/.zshrc
  fi

  fmt_information "🍺 persi.zsh-theme installed successfully."
}

setup_install_recommended_plugin() {
  PERSI_ZSH_RECOMMENDED_PLUGINS=(wd git gitignore git-flow git-flow-avh gh docker docker-compose kubectl npm node golang wp-cli composer yarn systemd systemadmin mvn mvnd nvm pip redis-cli supervisor gradle flutter brew rust jenv)
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
      if check_sed_is_gnu; then
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

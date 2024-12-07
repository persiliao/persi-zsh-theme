#!/usr/bin/env zsh

#Author: Persi.Liao(xiangchu.liao@gmail.com)
#Home: https://github.com/persiliao/persi-zsh-theme
#Description: Install persiliao.zsh-theme
#Version: 1.0.0

PERSILIAO_THEME_DIRECTORY="$(dirname "$(realpath "$0")")"

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

setup_theme() {
  fmt_tips "Do you want to activate persiliao theme? [Y/n] "
  read -r opt
  case $opt in
    Y*|y*|"") ;;
    N*|n*) fmt_notice "Activate persiliao theme skipped."; return ;;
    *) fmt_notice "Invalid choice. Activate persiliao theme skipped."; return ;;
  esac

  source "$HOME/.zshrc"

  # 确保环境变量已设置
  if [ -z "$ZSH_CUSTOM" ]; then
    fmt_notice "ZSH_CUSTOM is not set. Please check your zsh configuration."
    return
  fi

  # 复制主题文件
  cp "${PERSILIAO_THEME_DIRECTORY}/persiliao.zsh-theme" "$ZSH_CUSTOM/themes/persiliao.zsh-theme"

  # 让主题生效
  omz theme set persiliao
  omz theme use persiliao

  fmt_information "🍺 persiliao.zsh-theme installed successfully."

  # 提醒用户重新加载 .zshrc
  fmt_information "Please run 'omz reload' to activate the theme."
}

main() {
  setup_color
  check_ohmyzsh
  setup_theme
}

main

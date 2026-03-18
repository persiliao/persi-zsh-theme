#!/usr/bin/env zsh
#
# Optimized persi.zsh-theme installer
# Author: Persi.Liao(xiangchu.liao@gmail.com)
# Home: https://github.com/persiliao/persi-zsh-theme
# Description: Install persi.zsh-theme
# Version: 1.2.0
#
# Usage: ./install.sh
# This script will:
# 1. Check if oh-my-zsh is installed
# 2. Copy persi.zsh-theme to ~/.oh-my-zsh/custom/themes/
# 3. Use omz theme set persi to enable the theme
# 4. Provide instructions to reload with omz reload

set -e

# Get script directory
PERSI_THEME_DIRECTORY="$(cd "$(dirname "${0}")" && pwd)"

# Color support detection
if [ -t 1 ]; then
  is_tty() { true; }
else
  is_tty() { false; }
fi

# Color setup
setup_color() {
  if ! is_tty; then
    FMT_RED=""
    FMT_GREEN=""
    FMT_YELLOW=""
    FMT_BOLD=""
    FMT_RESET=""
    return
  fi

  FMT_RED=$(printf '\033[31m')
  FMT_GREEN=$(printf '\033[32m')
  FMT_YELLOW=$(printf '\033[33m')
  FMT_BOLD=$(printf '\033[1m')
  FMT_RESET=$(printf '\033[0m')
}

# Formatting functions
fmt_error() {
  printf '%sError: %s%s\n' "${FMT_BOLD}${FMT_RED}" "$*" "$FMT_RESET" >&2
}

fmt_success() {
  printf '%s%s%s\n' "${FMT_BOLD}${FMT_GREEN}" "$*" "$FMT_RESET"
}

fmt_info() {
  printf '%s%s%s\n' "${FMT_BOLD}${FMT_YELLOW}" "$*" "$FMT_RESET"
}

fmt_code() {
  printf '%s%s%s' "${FMT_BOLD}" "$*" "$FMT_RESET"
}

# Check if oh-my-zsh is installed
check_ohmyzsh() {
  if [ ! -d "${HOME}/.oh-my-zsh" ]; then
    fmt_error "oh-my-zsh is not installed."
    fmt_error "Please install oh-my-zsh first: https://github.com/ohmyzsh/ohmyzsh"
    exit 1
  fi

  # Also check for OMZ framework
  if [ ! -f "${HOME}/.oh-my-zsh/oh-my-zsh.sh" ]; then
    fmt_error "oh-my-zsh installation appears to be incomplete."
    fmt_error "Missing: ${HOME}/.oh-my-zsh/oh-my-zsh.sh"
    exit 1
  fi
}

# Try to set theme using omz command
try_set_theme_with_omz() {
  # fmt_info "Attempting to set theme using omz theme set persi..."

  # Method 1: Direct omz command if available
  if command -v omz >/dev/null 2>&1; then
    fmt_info "Using omz command from PATH..."
    if omz theme set persi; then
      fmt_info "✅ Theme set using omz theme set persi"
      return 0
    fi
  fi

  # Method 2: Source oh-my-zsh and use omz function
  # fmt_info "Attempting to source oh-my-zsh..."
  if [ -f "${HOME}/.oh-my-zsh/oh-my-zsh.sh" ]; then
    # Save current shell state
    local original_shell="$(ps -p $$ -o comm=)"

    if [ "$original_shell" = "zsh" ]; then
      # We're in zsh, try to source and use omz
      # fmt_info "Sourcing oh-my-zsh in current zsh session..."
      source "${HOME}/.oh-my-zsh/oh-my-zsh.sh" >/dev/null 2>&1

      if type omz >/dev/null 2>&1; then
        if omz theme set persi >/dev/null 2>&1; then
          # fmt_info "✅ Theme set via sourced omz function"
          return 0
        fi
      fi
    fi
  fi

  # Method 3: Run zsh in a sub-shell
  fmt_info "Attempting to run in zsh sub-shell..."
  if command -v zsh >/dev/null 2>&1; then
    if zsh -c "
      source ${HOME}/.oh-my-zsh/oh-my-zsh.sh >/dev/null 2>&1
      if type omz >/dev/null 2>&1; then
        omz theme set persi && echo 'SUCCESS'
      fi
    " 2>/dev/null | grep -q "SUCCESS"; then
      fmt_info "✅ Theme set via zsh sub-shell"
      return 0
    fi
  fi

  fmt_error "Failed to set theme using omz command"
  return 1
}

# Set theme directly (primary method)
set_theme_directly() {
  # fmt_info "Setting theme using omz theme set persi..."

  if try_set_theme_with_omz; then
    return 0
  fi

  # Fallback: Direct .zshrc modification
  fmt_info "Falling back to direct .zshrc modification..."
  update_zshrc_directly
}

# Fallback: Update .zshrc directly
update_zshrc_directly() {
  local zshrc_file="${HOME}/.zshrc"

  if [ ! -f "${zshrc_file}" ]; then
    fmt_error "ZSH configuration not found: ${zshrc_file}"
    exit 1
  fi

  # Check if ZSH_THEME is already set
  if grep -q "^[[:space:]]*ZSH_THEME=" "${zshrc_file}"; then
    # Replace existing ZSH_THEME line
    if sed --version 2>/dev/null | head -1 | grep -q -c GNU; then
      sed -i 's/^[[:space:]]*ZSH_THEME=.*/ZSH_THEME="persi"/g' "${zshrc_file}"
    else
      sed -i "" 's/^[[:space:]]*ZSH_THEME=.*/ZSH_THEME="persi"/g' "${zshrc_file}"
    fi
    fmt_info "✅ Updated existing ZSH_THEME in ${zshrc_file}"
  else
    # Add ZSH_THEME line after oh-my-zsh.sh is sourced
    local insert_line
    insert_line=$(grep -n "source.*oh-my-zsh.sh" "${zshrc_file}" | head -1 | cut -d: -f1)

    if [ -n "$insert_line" ]; then
      # Insert ZSH_THEME line before the source line
      if sed --version 2>/dev/null | head -1 | grep -q -c GNU; then
        sed -i "${insert_line}iZSH_THEME=\"persi\"" "${zshrc_file}"
      else
        sed -i "" "${insert_line}i\\
ZSH_THEME=\"persi\"
" "${zshrc_file}"
      fi
      fmt_info "✅ Added ZSH_THEME=\"persi\" to ${zshrc_file}"
    else
      # Just append to the end
      echo 'ZSH_THEME="persi"' >> "${zshrc_file}"
      fmt_info "✅ Appended ZSH_THEME=\"persi\" to ${zshrc_file}"
    fi
  fi

  return 0
}

# Install the theme
install_theme() {
  local theme_file="${PERSI_THEME_DIRECTORY}/persi.zsh-theme"
  local target_dir="${HOME}/.oh-my-zsh/custom/themes"
  local target_file="${target_dir}/persi.zsh-theme"

  # Check if theme file exists
  if [ ! -f "${theme_file}" ]; then
    fmt_error "Theme file not found: ${theme_file}"
    fmt_error "Please run this script from the directory containing persi.zsh-theme"
    exit 1
  fi

  # Create target directory if it doesn't exist
  if [ ! -d "${target_dir}" ]; then
    mkdir -p "${target_dir}"
    fmt_info "Created directory: ${target_dir}"
  fi

  # Copy theme file
  cp -f "${theme_file}" "${target_file}"
  fmt_info "✅ Copied theme to: ${target_file}"

  # Set the theme
  set_theme_directly

  # Verify the theme file is in place
  if [ -f "${target_file}" ]; then
    fmt_success "✅ persi.zsh-theme installed successfully!"
    show_instructions
  else
    fmt_error "Installation failed. Theme file not found at: ${target_file}"
    exit 1
  fi
}

# Show instructions
show_instructions() {
  fmt_info ""
  fmt_info "Installation complete! To use the theme:"
  fmt_info ""
  fmt_info "1. Reload your ZSH configuration:"
  fmt_info "   $(fmt_code "omz reload")"
  fmt_info ""
  fmt_info "2. Or restart your terminal"
  fmt_info ""
  fmt_info "3. Verify the theme is set:"
  fmt_info "   $(fmt_code 'echo $ZSH_THEME')"
  fmt_info "   Should output: $(fmt_code "persi")"
  fmt_info ""
  fmt_info "4. If the theme doesn't change, check:"
  fmt_info "   - Theme file exists at: $(fmt_code "${target_dir}/persi.zsh-theme")"
  fmt_info "   - .zshrc has: $(fmt_code "ZSH_THEME=\"persi\"")"
  fmt_info ""
  fmt_info "Need help? Visit: https://github.com/persiliao/persi-zsh-theme"
}

# Main function
main() {
  fmt_info "Starting persi.zsh-theme installation..."
  setup_color
  check_ohmyzsh
  install_theme
}

# Run main function
main "$@"

#!/bin/bash

set -e

# Check if yay is installed; if not, install it
function ensure_yay() {
  if ! command -v yay &>/dev/null; then
    echo "🚀 yay not found. Installing..."
    sudo pacman -S --needed --noconfirm base-devel git
    tmp_dir=$(mktemp -d)
    git clone https://aur.archlinux.org/yay.git "$tmp_dir/yay"
    cd "$tmp_dir/yay"
    makepkg -si --noconfirm
    cd ~
    rm -rf "$tmp_dir"
    echo "✅ yay installed successfully."
  fi
}

# Check if a package is installed using yay
function is_installed() {
  local package="$1"
  yay -Q "$package" &>/dev/null
}

# Install packages if not already installed
function install_package() {
  local packages=("$@")
  local to_install=()

  for pkg in "${packages[@]}"; do
    if ! is_installed "$pkg"; then
      to_install+=("$pkg")
    fi
  done

  if [ ${#to_install[@]} -ne 0 ]; then
    echo "📦 Installing packages: ${to_install[*]}"
    yay -S --noconfirm --needed "${to_install[@]}"
  else
    echo "✅ All base packages already installed."
  fi
}

# Ensure yay is available before any package actions
ensure_yay



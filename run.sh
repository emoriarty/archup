#!/bin/bash

# Print the logo
print_logo() {
    cat << "EOF"
    ___    ____  ________  ____  ______
   /   |  / __ \/ ____/ / / / / / / __ \
  / /| | / /_/ / /   / /_/ / / / / /_/ /
 / ___ |/ _, _/ /___/ __  / /_/ / ____/
/_/  |_/_/ |_|\____/_/ /_/\____/_/


EOF
}

# Clear the terminal and print the logo
clear
print_logo

# Exit on any error
set -e

# Source the package list
if [ ! -f "utils.sh" ]; then
  echo "Error: utils.sh not found!"
  exit 1
fi

source utils.sh

# Source the package list
if [ ! -f "packages.conf" ]; then
  echo "Error: packages.conf not found!"
  exit 1
fi

source packages.conf

# Update system with yay (covers both pacman and AUR)
echo "🔄 Updating system with yay..."
yay -Syu --noconfirm

# Install packages
echo "📦 Installing system packages..."
install_package "${SYSTEM_UTILS[@]}"
install_package "${DEV_TOOLS[@]}"

# Clean cache
echo "🧹 Cleaning package cache..."

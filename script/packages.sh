#!/bin/bash

set -e  # Exit immediately if a command fails

echo "Installing essential packages..."
sudo pacman -S --noconfirm --needed base-devel git neovim curl grep stow ansible timeshift grub-btrfs inotify-tools

echo "Installing Terminal Utilities..."
sudo pacman -S --noconfirm --needed htop zsh fzf tmux exa ripgrep

echo "Installing Development tools..."
sudo pacman -S --noconfirm --needed gcc zig npm docker docker-compose make python python-pip

echo "Installing Hyprland related packages..."
yay -S --noconfirm --needed hyprland waybar wofi

echo "Installing common programs..."
sudo pacman -S --noconfirm --needed firefox gimp telegram-desktop

echo "Installing Spotify from AUR..."
yay -S --noconfirm spotify

echo "All packages installed successfully!"


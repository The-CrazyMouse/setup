#!/bin/bash

set -e  # Exit immediately if a command fails

# Config Git
echo "Setting up Git user.name..."
git config --global user.name "The-CrazyMouse"

echo "Setting up Git user.email..."
git config --global user.email "andrerddantas@hotmail.com"

# Ensure Git is installed
echo "Ensuring Git is installed..."
sudo pacman -S --noconfirm --needed git

# Install Rust using rustup
echo "Installing Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install Zig manually
echo "Installing Zig..."

# Set the URL for the specific Zig version
ZIG_URL="https://ziglang.org/builds/zig-linux-x86_64-0.15.0-dev.77+aa8aa6625.tar.xz"

# Download Zig
echo "Downloading Zig..."
curl -LO $ZIG_URL

# Extract the tarball
echo "Extracting Zig..."
tar -xf "zig-linux-x86_64-0.15.0-dev.77+aa8aa6625.tar.xz"

# Move Zig to /usr/local or another directory in your PATH
echo "Installing Zig..."
sudo mv zig-linux-x86_64-0.15.0-dev.77+aa8aa6625/zig /usr/local/bin/

# Clean up
echo "Cleaning up..."
rm -rf zig-linux-x86_64-0.15.0-dev.77+aa8aa6625*

# Install Ghostty from pacman
echo "Ensuring Ghostty is installed..."
sudo pacman -S --noconfirm --needed ghostty

# Ensure Zsh is installed
echo "Ensuring Zsh is installed..."
sudo pacman -S --noconfirm --needed zsh

# Change the default shell to Zsh
echo "Changing the default shell to Zsh..."
sudo usermod -s /bin/zsh mouse

# Check if Oh My Zsh is already installed
echo "Checking if Oh My Zsh is installed..."
if [ ! -d "/home/mouse/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sudo -u mouse sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "Oh My Zsh is already installed."
fi

echo "Terminal Setup completed!"


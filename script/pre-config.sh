#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

echo "Starting system pre-setup..."

# Set the hostname if it's not already set
if [ "$(hostname)" != "mousehouse" ]; then
    echo "Setting hostname to mousehouse..."
    sudo hostnamectl set-hostname mousehouse
else
    echo "Hostname is already set correctly."
fi

# Ensure the user "mouse" exists and has sudo privileges
if ! id "mouse" &>/dev/null; then
    echo "Creating user 'mouse' and adding to the wheel group..."
    sudo useradd -m -G wheel mouse
else
    echo "User 'mouse' already exists."
fi

# Ensure "mouse" has sudo privileges
if ! sudo grep -q "^%wheel ALL=(ALL) ALL" /etc/sudoers; then
    echo "Adding 'mouse' to sudoers..."
    echo "%wheel ALL=(ALL) ALL" | sudo tee -a /etc/sudoers > /dev/null
else
    echo "User 'mouse' already has sudo privileges."
fi

# Set system locale to en_GB.UTF-8
if ! grep -q "en_GB.UTF-8" /etc/locale.gen; then
    echo "Configuring locale to en_GB.UTF-8..."
    echo "en_GB.UTF-8 UTF-8" | sudo tee -a /etc/locale.gen > /dev/null
    sudo locale-gen
else
    echo "Locale is already configured."
fi

echo "Setting LANG=en_GB.UTF-8 in /etc/locale.conf..."
echo "LANG=en_GB.UTF-8" | sudo tee /etc/locale.conf > /dev/null

# Ensure the "kbd" package is installed
if ! pacman -Q kbd &>/dev/null; then
    echo "Installing kbd package..."
    sudo pacman -S --noconfirm --needed kbd
else
    echo "kbd package is already installed."
fi

# Set the keyboard layout to Portuguese
echo "Setting keyboard layout to pt-latin9..."
#sudo localectl set-keymap pt-latin9

# Update pacman packages
echo "Updating system packages..."
sudo pacman -Syu --noconfirm

#yay
echo "Installing yay"
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..

# Update AUR packages using yay (if available)
if command -v yay &>/dev/null; then
    echo "Updating AUR packages using yay..."
    yay -Syu --noconfirm
else
    echo "yay not found, skipping AUR package update."
fi

echo "Pre-setup completed successfully!"


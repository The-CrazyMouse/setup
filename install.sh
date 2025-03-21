#!/bin/bash

set -e  # Exit immediately if a command fails

echo "Installing essential packages for the installation process..."
sudo pacman -S --noconfirm --needed git timeshift grub-btrfs git-credential-manager

# Creating a snapshot before configuration
echo "Creating a pre-setup snapshot..."
sudo timeshift --create --comments "Pre-Config"

# Setting up grub-btrfs
echo "Setting up grub-btrfs..."
sudo /etc/grub.d/41_snapshots-btrfs
sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo systemctl edit --full grub-btrfsd

# Enabling grub-btrfsd service to automatically add snapshots
echo "Enabling automatic snapshot integration..."
sudo systemctl enable --now grub-btrfsd

echo "Configuring Git to use credential manager..."
git config --global credential.helper manager-core

# Cloning setup repository
echo "Fetching setup scripts..."
git clone https://github.com/The-CrazyMouse/setup.git ./setup

# Entering the scripts folder
cd setup/scripts

# Making sure all scripts are executable
echo "Making scripts executable..."
chmod +x pre-setup.sh packages.sh terminal.sh dotfiles.sh

# Running setup scripts
echo "Running pre-setup..."
./pre-setup.sh

echo "Installing packages..."
./packages.sh

echo "Configuring terminal..."
./terminal.sh

echo "Applying dotfiles..."
./dotfiles.sh

# Moving out of the repo and cleaning up
cd ../..
echo "Cleaning up setup repository..."
rm -rf setup

# Creating a final snapshot after setup
echo "Creating post-setup snapshot..."
sudo timeshift --create --comments "Post-Config"


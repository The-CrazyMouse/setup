#!/bin/bash

# install need packages for the instaall
sudo pacman -S git ansible timeshift grub-btrfs inotify-tools

# Creating a snapshot
sudo timeshift --create --comments "Pre-Config"

# Setting up the grub-btrfs
sudo /etc/grub.d/41_snapshots-btrfs
sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo systemctl edit --full grub-btrfsd

# Enabling to automatically add snapshots
sudo systemctl start grub-btrfsd
sudo systemctl enable grub-btrfsd

# Coloning Repo
git clone https://github.com/The-CrazyMouse/setup.git ./setup

# Moving inside
cd setup/ansible

# Running ansible
ansible-playbook -i hosts local.yml

# Uninstalling ansible
sudo pacman -Rns ansible

# Moving out of the repo
cd ../..

# Removing the repo
rm -rf setup

# snapshot final
sudo timeshift --create --comments "Pre-Config"

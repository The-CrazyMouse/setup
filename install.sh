#!/bin/bash

sudo pacman -S git ansible

git clone https://github.com/The-CrazyMouse/setup.git ./setup

cd setup/ansible

ansible-playbook -i hosts local.yml

sudo pacman -Rns ansible

cd ../..

rm -rf setup

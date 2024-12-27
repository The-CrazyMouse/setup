#!/bin/bash

sudo pacman -S git ansible

git clone https://github.com/The-CrazyMouse/setup.git ./setup

cd setup

chmod

./install.sh

sudo pacman -Rns ansible

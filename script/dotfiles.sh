#!/bin/bash

# Define your base directories
DOTFILES_DIR="$HOME/dotfiles"
NVIM_DIR="$DOTFILES_DIR/nvim"

# Clone the dotfiles repository
echo "Cloning dotfiles repository..."
git clone git@192.168.1.100:/home/git/repos/dotfiles.git "$DOTFILES_DIR"

# Clone the nvim repository into the dotfiles directory
echo "Cloning nvim repository into dotfiles directory..."
git clone git@192.168.1.100:/home/git/repos/nvim.git "$NVIM_DIR"

# Check if stow is installed, if not, install it
if ! command -v stow &> /dev/null; then
    echo "stow is not installed. Installing..."
    sudo pacman -S stow  # Use `pacman` for Arch Linux
fi

# Stow dotfiles and replace any existing files
echo "Stowing dotfiles (replacing existing files)..."
cd "$DOTFILES_DIR"
stow -R *  # This will force stow to replace any conflicting files

# Optionally, if you want to move the nvim config to the right place
echo "Setting up nvim config..."
# You could symlink the nvim config to the appropriate directory if needed
# ln -s "$NVIM_DIR" "$HOME/.config/nvim"  # Uncomment if you want to use nvim from here

echo "Done setting up dotfiles and nvim."


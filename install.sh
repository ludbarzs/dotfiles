#!/bin/bash

#Installing packages
echo "Updateing system..."
sudo pacman -Syu --noconfirm

echo "Installing packages..."
sudo pacman -S alacritty --noconfirm
sudo pacman -S neovim --noconfirm
sudo pacman -S tmux --noconfirm

USER_HOME=$(eval echo ~$SUDO_USER)
DOTFILES_DIR="$USER_HOME/source-code/.dotfiles"
CONFIG_DIR="$USER_HOME/.config"

FILES=($(ls $DOTFILES_DIR))  # Automatically list all files in the directory

for FILE in "${FILES[@]}"; do
    ln -sfn "$DOTFILES_DIR/$FILE" "$CONFIG_DIR/$FILE"
    echo "Linked $DOTFILES_DIR/$FILE -> $CONFIG_DIR/$FILE"
done


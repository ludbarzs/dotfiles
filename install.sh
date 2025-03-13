#!/bin/bash

#Installing packages
echo "Updateing system..."
sudo pacman -Syu --noconfirm

echo "Installing packages..."
sudo pacman -S alacritty --noconfirm
sudo pacman -S neovim --noconfirm
sudo pacman -S tmux --noconfirm
sudo pacman -S picom --noconfirm
sudo pacman -S neofetch --noconfirm
sudo pacman -S rofi --noconfirm
sudo pacman -S spotify-launcher --noconfirm

read -p "Just a Reminder: To apply spotify theme you need yay and spiceify! (y/n): " user_input

if
USER_HOME=$(eval echo ~$SUDO_USER)
DOTFILES_DIR="$USER_HOME/source-code/.dotfiles"
CONFIG_DIR="$USER_HOME/.config"

FILES=($(ls $DOTFILES_DIR)) # Automatically list all files in the directory

for FILE in "${FILES[@]}"; do
    if [ -d "$DOTFILES_DIR/$FILE" ]; then
        ln -sfn "$DOTFILES_DIR/$FILE" "$CONFIG_DIR/$FILE"
        echo "Linked $DOTFILES_DIR/$FILE -> $CONFIG_DIR/$FILE"
    else
        echo "Skipping (not a directory): $DOTFILES_DIR/$FILE"
    fi
done

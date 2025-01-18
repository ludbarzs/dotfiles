#!/bin/bash
mkdir -p "$CONFIG_DIR"
DOTFILES_DIR=~/source-code/.dotfiles
CONFIG_DIR=~/.config

FILES=($(ls /home/user/dotfiles))  # Automatically list all files in the directory

for FILE in "${FILES[@]}"; do
    ln -sfn "$DOTFILES_DIR/$FILE" "$CONFIG_DIR/$FILE"
    echo "Linked $DOTFILES_DIR/$FILE -> $CONFIG_DIR/$FILE"
done


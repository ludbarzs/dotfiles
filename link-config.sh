#!/bin/bash

HOME_DIR="$HOME"
CONFIG_DIR="${HOME_DIR}/.config"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "By continuing this script the dotfiles in this repo will be replaced in your .config and $HOME"
read -rp "Proceed? [y/N]  " reply
if [[ "$reply" =~ ^[Yy] ]]; then
  echo "Linking configs from $SCRIPT_DIR to $CONFIG_DIR"

  # For every directory in the directoyr where script is
  for d in "$SCRIPT_DIR"/*/; do
    dir_name=$(basename "$d")
    echo "$dir_name"

    config_path="$CONFIG_DIR/$dir_name"

        rm -rf "$config_path" || { echo "Error: failed to remove existing directory " >&2; exit 1; }

    ln -s "$d" "$CONFIG_DIR"
  done

  # For every .file in directory where script is
  for file in "$SCRIPT_DIR"/.*; do
    # Check that files are not . .. or .git (dir)
    if [[ "$file" == "$SCRIPT_DIR/." || "$file" == "$SCRIPT_DIR/.." || -d "$file" ]]; then
      continue
    fi
    target_path="$HOME/$(basename "$file")" 
    if [ -e "$target_path" ]; then
      echo "Removing existing file: $target_path"
      rm -rf "$target_path" || { echo "Error: failed to remove existing directory " >&2; exit 1; }
    fi
    ln -s "$file" "$HOME"
  done
else
  echo "Goodbye!"
fi




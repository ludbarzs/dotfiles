#!/bin/bash
HOME_DIR="$HOME"
CONFIG_DIR="${HOME_DIR}/.config"

check_sudo() {

}


if [ ! -d "$CONFIG_DIR" ]; then
	echo "Creating .config for $USER"
	# mkdir -p "$CONFIG_DIR"
fi

echo "$HOME_DIR"
echo "$CONFIG_DIR"
echo "$DIR"

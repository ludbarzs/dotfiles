#!/bin/bash
# TODO: Make a quicker option to preform the symlinks
# TODO: Add yay dependencie install provided yay is installed for librewolf
HOME_DIR="$HOME"
CONFIG_DIR="${HOME_DIR}/.config"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Does to user want to override .config files?
BACKUP_CONFIG="" # True

check_sudo() {
  if ! sudo -v; then
    echo "ERROR: Sudo access required." >&2
    exit 1
  fi
}

install_yay() {
  if command -v yay &>/dev/null; then
    echo "yay is already installed"
    return
  fi

  read -rp "Do you want to install yay (AUR package manager)? [y/N] " reply
  if [[ "$reply" =~ ^[Yy] ]]; then
    check_sudo # Verify sudo access
    sudo pacman -S --needed git base-devel || return 1

    # Make a temp dir to avoid clutter
    temp_dir=$(mktemp -d)
    git clone https://aur.archlinux.org/yay.git "$temp_dir/yay" || return 1
    cd "$temp_dir/yay" || return 1
    makepkg -si --noconfirm || return 1

    echo "yay installed successfully"

    # Removes temp dir in /tmp
    rm -rf "$temp_dir"
  else
    echo "Skipping yay install (Script may break)"
  fi
}

install_yay

install_dependencies() {
  echo "This scrip requires sudo to install some dependencies you can skip this step and install the dependencies yourself"
  read -rp "Proceed? [y/N] " reply
  if [[ "$reply" =~ ^[Yy] ]]; then
    check_sudo # Verify sudo access

    # Ensure fastest pacman downloads
    sudo pacman -Syu --needed reflector rsync

    # Ensure optimal mirror location with reflector
    echo "The script is going to update your /etc/pacman.d/mirrorlist for optimal package download with pacman (Latvia centric)"
    echo "This might take a moment..."
    if sudo reflector \
      --sort rate \
      --latest 200 \
      --country "Latvia,Lithuania,Estonia,Germany,Sweden,Poland,Denmark,Finland" \
      --protocol https \
      --download-timeout 2 \
      --connection-timeout 2 \
      --save /etc/pacman.d/mirrorlist 2>/dev/null; then

      echo "Mirrorlist successfully updated"
    else
      echo "Failed to update mirrors!" >&2
    fi

    # For vim wl-clipboard, npm, nodejs, curl
    sudo pacman -Syu --needed nvim npm nodejs curl unzip fd python-pywal tree-sitter-cli lazygit spotify-launcher feh dolphin flameshot xcolor zsh fzf zoxide polybar xclip

  else
    echo "Skipping dependencies"
  fi
}

install_dependencies

create_dirs() {
  echo "Creating Downloads, Pictures, Documents in $HOME"
  mkdir -p "$HOME/Downloads"
  mkdir -p "$HOME/Documents"
  mkdir -p "$HOME/Pictures"
}

create_dirs

if [ ! -d "$CONFIG_DIR" ]; then
  echo "Creating .config for $USER"
  mkdir -p "$CONFIG_DIR"
fi

# If a directory exists in .config the user will be given choices of:
# 1. mv .config/current to ./config/current.bak (default)
# 2. replace
dir_exists() {
  # path in dotfiles for file (e.g. nvim)
  source="$1"
  # path to .config for file (e.g. nvim)
  target="$2"

  if [[ "$BACKUP_CONFIG" == "" ]]; then
    echo "$target already exists"
    echo "What do you want to do for all the conflicting files:"
    echo "1 - Move to $target.bak and link"
    echo "2 - Replace $target with $source"

    read -p "Enter your choice [1-2]: " reply

    if [[ "$reply" == "1" ]]; then
      BACKUP_CONFIG=0 # Create backup
    fi
    if [[ "$reply" == "2" ]]; then
      BACKUP_CONFIG=1 # Don't create backup
    fi
  fi

  case "$BACKUP_CONFIG" in
  0)
    echo "Moving $target to $target.bak"
    mv "$target" "$target.bak"
    ln -s "$source" "$target"
    ;;
  1)
    read -rp "Deleting $target! Are you sure? " confirm
    if [[ "$confirm" =~ ^[Yy] ]]; then
      rm -rf "$target"
      ln -s "$source" "$target"
    else
      dir_exists "$source" "$target"
    fi
    ;;
  *)
    dir_exists "$source" "$target"
    ;;
  esac
}

# If creates symlinks between current .dotfiles and .config
link_configs() {
  echo "Linking configurations from $SCRIPT_DIR to $CONFIG_DIR"

  # For every directory in the directory where script is
  for d in "$SCRIPT_DIR"/*/; do
    # Get name of the dir without path (e.g. from dotfiles/nvim to nvim)
    dir_name=$(basename "$d")

    # Path to .config/target (e.g. /.config/nvim)
    config_path="$CONFIG_DIR/$dir_name"
    if [[ -d "$config_path" ]]; then
      echo "$config_path exists"
      # Prompt user with options if directory exists in .config
      dir_exists "$d" "$CONFIG_DIR/$dir_name"

    else # Directory does not exist in .confg
      # Create the symlink
      ln -s "$d" "$CONFIG_DIR/$dir_name"
      echo "Symlink created $CONFIG_DIR/$dir_name"
    fi
  done

  # For every .flie in directory where script is
  for file in "$SCRIPT_DIR"/.*; do
    # Check that files are not . .. vai .git (dir)
    if [[ "$file" == "$SCRIPT_DIR/." || "$file" == "$SCRIPT_DIR/.." || -d "$file" ]]; then
      continue
    fi

    file_name=$(basename "$file")
    target_path="$HOME/$file_name"
    case "$file_name" in
    .git | .gitignore | .DS_Store | install.sh)
      continue
      ;;
    esac

    if [[ -e "$target_path" ]]; then
      echo "$target_path exists"

      dir_exists "$file" "$target_path"
    else
      ln -s "$file" "$target_path"
      echo "Symlink created: $target_path -> $file"
    fi
  done
}

link_configs

# Set zsh as default shell
set_zsh() {
  if command -v zsh >/dev/null 2>&1; then
    echo "Zsh is installed."
    read -rp "Do you want to set zsh as your default shell? [y/N] " reply
    if [[ "$reply" =~ ^[Yy] ]]; then
      chsh -s "$(command -v zsh)"
      echo "Zsh has been set as your default shell. You may need to log out and back in."
    else
      echo "Default shell change canceled."
    fi
  else
    echo "Zsh is not installed."
  fi
}

set_zsh

#!/bin/bash
set -e

PACKAGES="lazygit ripgrep fd tree-sitter-cli gcc unzip wl-clipboard nodejs npm python python-pip luarocks firefox nvim zsh quickshell fastfetch matugen kitty zoxide hyprpaper ncspot"
AUR_PACKAGES="wallust elecwhat-bin"
DOTFILES_LINK_SCRIPT="$HOME/source-code/dotfiles/link-config.sh"

confirm() {
  local prompt="$1"
  read -rp "$prompt [y/N] " reply
  [[ "$reply" =~ ^[Yy] ]]
}

# --- 1. Install pacman packages (includes base-devel + git, needed later for yay) ---
if confirm "Install pacman packages (base-devel, git, and: $PACKAGES)?"; then
  sudo pacman -S --needed base-devel git $PACKAGES
else
  echo "Skipping pacman package install."
fi

# --- 2. Install yay (AUR helper) ---
if command -v yay &>/dev/null; then
  echo "yay is already installed, skipping."
else
  if confirm "yay not found. Install yay now?"; then
    tmp_dir=$(mktemp -d)
    git clone https://aur.archlinux.org/yay.git "$tmp_dir/yay"
    (cd "$tmp_dir/yay" && makepkg -si)
    rm -rf "$tmp_dir"
  else
    echo "Skipping yay install."
  fi
fi

# --- 2b. Install yay packages ---
if command -v yay &>/dev/null; then
  if confirm "Install AUR packages via yay ($AUR_PACKAGES)?"; then
    yay -S --needed $AUR_PACKAGES
  else
    echo "Skipping AUR package install."
  fi
else
  echo "yay not found, skipping AUR package install."
fi

# --- 2c. Install SFMono Nerd Font (Ligaturized) ---
if confirm "Install SFMono Nerd Font (Ligaturized)?"; then
  mkdir -p "$HOME/.local/share/fonts"
  tmp_dir=$(mktemp -d)
  git clone https://github.com/shaunsingh/SFMono-Nerd-Font-Ligaturized.git "$tmp_dir/SFMono-Nerd-Font-Ligaturized"
  cp "$tmp_dir/SFMono-Nerd-Font-Ligaturized"/*.otf "$HOME/.local/share/fonts"
  rm -rf "$tmp_dir"
  fc-cache -f "$HOME/.local/share/fonts" &>/dev/null || true
else
  echo "Skipping font install."
fi


# --- 3. Link dotfiles ---
if confirm "Run link-config.sh to symlink dotfiles?"; then
  if [ -x "$DOTFILES_LINK_SCRIPT" ]; then
    "$DOTFILES_LINK_SCRIPT"
  elif [ -f "$DOTFILES_LINK_SCRIPT" ]; then
    bash "$DOTFILES_LINK_SCRIPT"
  else
    echo "Error: $DOTFILES_LINK_SCRIPT not found." >&2
  fi
else
  echo "Skipping dotfiles linking."
fi

# --- 4. Change default shell to zsh ---
if confirm "Change default shell to zsh?"; then
  if [ "$SHELL" = "$(command -v zsh)" ]; then
    echo "zsh is already your default shell, skipping."
  else
    chsh -s "$(command -v zsh)"
  fi
else
  echo "Skipping shell change."
fi

# --- 5. Install zinit ---
ZINIT_DIR="$HOME/.local/share/zinit/zinit.git"
if [ -d "$ZINIT_DIR" ]; then
  echo "zinit is already installed, skipping."
else
  if confirm "Install zinit (zsh plugin manager)?"; then
    bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
  else
    echo "Skipping zinit install."
  fi
fi

# --- 6. Create swap file ---
if confirm "Set up a swap file?"; then
  SWAP_FILE="/swapfile"

  if [ -f "$SWAP_FILE" ]; then
    echo "Swap file already exists at $SWAP_FILE, skipping."
  else
    read -rp "Choose swap size - 10 or 20 (GB): " swap_choice
    case "$swap_choice" in
      10) SWAP_SIZE="10G" ;;
      20) SWAP_SIZE="20G" ;;
      *)
        echo "Invalid choice, skipping swap file creation."
        SWAP_SIZE=""
        ;;
    esac

    if [ -n "$SWAP_SIZE" ]; then
      sudo fallocate -l "$SWAP_SIZE" "$SWAP_FILE"
      sudo chmod 600 "$SWAP_FILE"
      sudo mkswap "$SWAP_FILE"
      sudo swapon "$SWAP_FILE"

      if ! grep -q "^$SWAP_FILE " /etc/fstab; then
        echo "$SWAP_FILE none swap defaults 0 0" | sudo tee -a /etc/fstab >/dev/null
      fi

      echo "Swap file of $SWAP_SIZE created and enabled."
    fi
  fi
else
  echo "Skipping swap file creation."
fi

echo "Done."




# Hyprland dotfiles

Dotflies by [ludbarzs](https://github.com/ludbarzs)

# Description

...

# Installation

Autmatic installation can be done with the install.sh script (For Arch Linux)

## What it does

- Installs yay (AUR helper) if needed
- Installs basic dependencies (Firefox, Neovim, tree-sitter-cli, lazygit)
- Creates symlinks from your dotfiles to ~/.config/ and ~/
- Safely handles existing configurations with backup options

1. Clone this repository:
   > [!IMPORTANT]
   > This repository should be cloned to `$HOME/source-code`.

```bash
git clone https://github.com/ludbarzs/dotfiles.git
cd dotflies
```

1.5 Run the link-config.sh script to link you config to mine (_will delete you current config!_)

```bash
bash link-config.sh
```

2. Run the install script (Currently not working)

```bash
bash install.sh
```

3. Follow the prompts to:

- Install yay (optional but recommended)
- Install dependencies (requires sudo)
- Handle existing config files

# Install Nvidia drivers for my device

## Pre-requisites & Setup

### 1. Enable Multilib Repository

Ensures 32-bit application support (for Steam/Wine).

```bash
sudo nano /etc/pacman.conf
```

Uncomment the following lines (remove the `#`):

```ini
[multilib]
Include = /etc/pacman.d/mirrorlist
```

Sync package databases:

```bash
sudo pacman -Syy
```

### 2. Install Kernel Headers

DKMS requires kernel headers matching your running kernel to compile modules:

```bash
sudo pacman -S linux-headers
```

### 3. Clean Up Old Conflicts

Remove the open driver and any conflicting nvidia-utils packages before installing the legacy branch:

```bash
sudo pacman -Rdd lib32-nvidia-utils nvidia-utils nvidia-open-dkms
```

---

## Manual Driver Build & Installation (AUR)

The legacy driver must be built from the AUR using `makepkg` directly (bypasses version-pinning conflicts some AUR helpers hit with legacy branches).

### 1. Install the kernel module (DKMS)

```bash
mkdir -p ~/nvidia-fix && cd ~/nvidia-fix
git clone --depth 1 https://aur.archlinux.org/nvidia-580xx-dkms.git
cd nvidia-580xx-dkms
makepkg -siC
```

### 2. Install 64-bit driver utilities

```bash
cd ~/nvidia-fix
git clone --depth 1 https://aur.archlinux.org/nvidia-580xx-utils.git
cd nvidia-580xx-utils
makepkg -siC
```

(Accept all prompts to remove conflicting packages during installation.)

### 3. Install 32-bit utilities (Steam support)

```bash
cd ~/nvidia-fix
git clone --depth 1 https://aur.archlinux.org/lib32-nvidia-580xx-utils.git
cd lib32-nvidia-580xx-utils
makepkg -si
```

---

## After Install

1. Rebuild initramfs/UKI:

```bash
   sudo mkinitcpio -P

```

3. Reboot.
4. Verify:

```bash
   nvidia-smi
   lsmod | grep nvidia
   lspci -k | grep -A 3 VGA

```

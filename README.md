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

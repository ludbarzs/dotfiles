# My i3 Dotfiles

Dotflies by [ludbarzs](https://github.com/ludbarzs)

# Installation

Autmatic installation can be done with the install.sh script (For Arch Linux)

## What it does

- Installs yay (AUR helper) if needed
- Installs basic dependencies (Firefox, Neovim, tree-sitter-cli, lazygit)
- Creates symlinks from your dotfiles to ~/.config/ and ~/
- Safely handles existing configurations with backup options

1. Clone this repository:

```bash
git clone --branch i3-t440 --single-branch https://github.com/ludbarzs/dotfiles.git
cd dotflies
```

2. Run the install script

```bash
bash install.sh
```

3. Follow the prompts to:

- Install yay (optional but recommended)
- Install dependencies (requires sudo)
- Handle existing config files

### On a new machine

1. Clone my dotfiles: git clone https://github.com/ludbarzs/dotfiles.git ~/source-code/.dotfiles
2. Symlink from .dotfiles to .config per file:
   1. ln -s ~/source-code/.dotfiles/i3 ~/.config/i3
   2. or run install.sh
      1. Give install.sh run executable permissions:
         chmod +x install.sh
      2. Run the script:
         ./install.sh
3. There are files like .zshrc and .p10k that are meant to go in your home directory, they install scirpt does not yet include them
   - Make seperate symlinks for /home files

### Packages if I ever reinstall will be useful

- Only started collecting after April 27 2025
- Loud beeping diabled on error:
  - https://wiki.archlinux.org/title/PC_speaker
- Dolphin finds programs to open files with:
  - https://www.lorenzobettini.it/2024/05/fixing-the-empty-open-with-in-dolphin-in-hyprland/
- Firefox use dolphin:
  - https://wiki.archlinux.org/title/Firefox#XDG_Desktop_Portal_integration

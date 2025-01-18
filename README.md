### On a new machine
1. Clone my dotfiles: git clone https://github.com/ludbarzs/dotfiles.git ~/source-code/.dotfiles
	I doing commits, make sure git is in ssh, not https mode: [[Git#https to SSH]]
2. Symlink from .dotfiles to .config per file: 
	1. ln -s ~/source-code/.dotfiles/i3 ~/.config/i3
	2. or run install.sh
		1. Give install.sh run executable permissions:
			chmod +x install.sh
		2. Run the script:
			./install.sh
### 


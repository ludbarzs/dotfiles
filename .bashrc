#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias lo='libreoffice'
PS1='[\u@\h \W]\$ '
export PATH="/home/arg/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="/home/arg/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"
export PATH="$HOME/bin:$PATH"

# Starts SSH agent
if ! pgrep -u "$USER" ssh-agent >/dev/null; then
    ssh-agent -t 1h >"$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

# Load color variables
source ~/.config/colors/tokyonight-moon.conf

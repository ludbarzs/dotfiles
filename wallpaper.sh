#!/usr/bin/env bash
{
  echo "PATH=$PATH"
  echo "which wallust: $(which wallust)"
  echo "FULL_PATH=$FULL_PATH"
  wallust run "$FULL_PATH" -v
} > /tmp/wallust-debug.txt 2>&1
WALL_DIR="$HOME/Pictures"
HYPRPAPER_CONF="$HOME/source-code/dotfiles/hypr/hyprpaper.conf"
selected=$(find "$WALL_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -printf "%f\n" | rofi -dmenu -p "Wallpaper")
[ -z "$selected" ] && exit 0
FULL_PATH="$WALL_DIR/$selected"
TILDE_PATH="~/${FULL_PATH#$HOME/}"
sed -i "s|^    path = .*|    path = $TILDE_PATH|" "$HYPRPAPER_CONF"
hyprctl hyprpaper unload all
hyprctl hyprpaper preload "$FULL_PATH"
hyprctl hyprpaper wallpaper ",$FULL_PATH"
wallust run "$FULL_PATH"
kill -SIGUSR1 $(pgrep kitty)
# 4. Reload eww with new wallust colors
# eww kill
# eww open bar
# eww update volume-live=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf "%d", $2 * 100}')
# eww update brightness-live=$(brightnessctl -m | awk -F, '{print substr($4, 1, length($4)-1)}')

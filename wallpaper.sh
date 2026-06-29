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
# hyprpaper.conf uses ~ in the path, so keep that style for consistency
TILDE_PATH="~/${FULL_PATH#$HOME/}"

# 1. Update hyprpaper.conf
sed -i "s|^    path = .*|    path = $TILDE_PATH|" "$HYPRPAPER_CONF"

# 2. Reload hyprpaper with the new wallpaper
hyprctl hyprpaper unload all
hyprctl hyprpaper preload "$FULL_PATH"
hyprctl hyprpaper wallpaper ",$FULL_PATH"

# 3. Run wallust to regenerate colors/templates
wallust run "$FULL_PATH"

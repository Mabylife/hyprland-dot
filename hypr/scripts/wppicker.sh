#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/wallpapers"
SYMLINK_PATH="$HOME/.config/hypr/current_wallpaper"
SDDM_WALLPAPER_PATH="/usr/share/sddm/themes/simple-sddm/Backgrounds/sync.png"

cd "$WALLPAPER_DIR" || exit 1

IFS=$'\n'

IMAGES=$(ls -t *.jpg *.png *.gif *.jpeg 2>/dev/null)

echo "$IMAGES" | xargs -I{} -P 8 bash -c "
  ICON_PATH=\"/tmp/rofi_icon_\$1.png\"
  if [ ! -f \"\$ICON_PATH\" ]; then
    convert \"\$1\" -gravity center -crop 1080x1080+0+0 -resize 300x300! \"\$ICON_PATH\"
  fi
" _ {}

ROFI_LIST=""
for a in $IMAGES; do
    ICON_PATH="/tmp/rofi_icon_${a}.png"
    ROFI_LIST+="$a\0icon\x1f$ICON_PATH\n"
done

SELECTED_WALL=$(echo -en "$ROFI_LIST" | rofi -dmenu -p -theme wallpaper.rasi "")
[ -z "$SELECTED_WALL" ] && exit 1
SELECTED_PATH="$WALLPAPER_DIR/$SELECTED_WALL"

/home/mabylife/.cargo/bin/matugen image "$SELECTED_PATH"

mkdir -p "$(dirname "$SYMLINK_PATH")"
ln -sf "$SELECTED_PATH" "$SYMLINK_PATH"

convert "$SELECTED_PATH" "$SDDM_WALLPAPER_PATH"
ln -sf "$SDDM_WALLPAPER_PATH" "$SDDM_WALLPAPER_PATH"

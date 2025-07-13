#!/usr/bin/env bash

WALLPAPER_PATH="$HOME/Pictures/wallpaper/"
CURRENT_WALLPAPER=$(hyprctl hyprpaper listloaded)

# get monitor
MONITOR=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')

# gacha wallpaper
WALLPAPER=$(find "$WALLPAPER_PATH" -type f ! -name "$(basename "$CURRENT_WALLPAPER")" | shuf -n 1)

# set wallpaper
hyprctl hyprpaper reload "$MONITOR","$WALLPAPER"

# generate palet warna
wallust run "$WALLPAPER"

# write hyprlock config
cat <<EOF > "$HOME/.config/hypr/hyprlock/background.conf"
background {
    monitor =
    path = $WALLPAPER

    blur_size = 3
    blur_passes = 2

    zindex = -1
}
EOF

# write hyprpaper config
cat <<EOF > "$HOME/.config/hypr/hyprpaper.conf"
preload = $WALLPAPER
wallpaper = $MONITOR, $WALLPAPER
EOF
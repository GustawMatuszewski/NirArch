#!/bin/bash
source ~/.config/globalStyle

# Update Colors in all Wofi CSS files without touching geometry
# We use a loop to target any .css file in the wofi folder
for css in ~/.config/wofi/*.css; do
    [ -e "$css" ] || continue
    sed -i "s/background-color: #.*;/background-color: $BG_COLOR;/g" "$css"
    sed -i "s/border: .* solid #.*;/border: 2px solid $ACCENT_COLOR;/g" "$css"
    sed -i "s/background-color: #.*; \/* selection \*\//background-color: $ACCENT_COLOR; \/* selection \*\//g" "$css"
    sed -i "s/color: #.*; \/* text-selection \*\//color: $BG_COLOR; \/* text-selection \*\//g" "$css"
done

# Sync Alacritty
sed -i "s/background = '#.*'/background = '$BG_COLOR'/g" ~/.config/alacritty/alacritty.toml
sed -i "s/background = '#.*' # selection/background = '$ACCENT_COLOR' # selection/g" ~/.config/alacritty/alacritty.toml

# Sync Waybar
sed -i "s/@define-color bg #.*;/@define-color bg $BG_COLOR;/g" ~/.config/waybar/style.css
sed -i "s/@define-color accent #.*;/@define-color accent $ACCENT_COLOR;/g" ~/.config/waybar/style.css

# Sync Niri
sed -i "s/active-color \".*\"/active-color \"${ACCENT_COLOR}ff\"/g" ~/.config/niri/config.kdl
sed -i "s/inactive-color \".*\"/inactive-color \"${ACCENT_COLOR}ff\"/g" ~/.config/niri/config.kdl

# Sync SwayNC
for css in ~/.config/swaync/*.css; do
    [ -e "$css" ] || continue
    sed -i "s/#e69934/${ACCENT_COLOR}/g" "$css"
    sed -i "s/rgba(44, 41, 41/rgba($(printf '%d, %d, %d' 0x${BG_COLOR:1:2} 0x${BG_COLOR:3:2} 0x${BG_COLOR:5:2})/g" "$css"
    sed -i "s/rgb(44, 41, 41/rgb($(printf '%d, %d, %d' 0x${BG_COLOR:1:2} 0x${BG_COLOR:3:2} 0x${BG_COLOR:5:2})/g" "$css"
    sed -i "s/#2c2929/${BG_COLOR}/g" "$css"
done

# Sync SwayLock
if [ -f ~/.config/swaylock/config ]; then
    sed -i "s/ring-color=.*/ring-color=${ACCENT_COLOR:1}ff/g" ~/.config/swaylock/config
    sed -i "s/key-hl-color=.*/key-hl-color=${ACCENT_COLOR:1}ff/g" ~/.config/swaylock/config
    sed -i "s/ring-clear-color=.*/ring-clear-color=${ACCENT_COLOR:1}ff/g" ~/.config/swaylock/config
    sed -i "s/inside-color=.*/inside-color=${BG_COLOR:1}00/g" ~/.config/swaylock/config
    sed -i "s/inside-clear-color=.*/inside-clear-color=${BG_COLOR:1}cc/g" ~/.config/swaylock/config
    sed -i "s/inside-ver-color=.*/inside-ver-color=${BG_COLOR:1}cc/g" ~/.config/swaylock/config
    sed -i "s/inside-wrong-color=.*/inside-wrong-color=${BG_COLOR:1}cc/g" ~/.config/swaylock/config
fi

# Reload everything
swaync-client -rs 2>/dev/null
pkill -SIGUSR2 waybar 2>/dev/null

echo "Colors synced globally. Geometry is now up to you in each script/css."
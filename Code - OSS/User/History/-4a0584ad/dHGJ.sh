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

echo "Colors synced globally. Geometry is now up to you in each script/css."
#!/bin/bash
source ~/.config/globalStyle

# Function to generate CSS
gen_css() {
    local file=$1; local w=$2; local h=$3
    cat <<EOF > "$file"
* { font-family: "JetBrainsMono Nerd Font"; font-size: $FONT_SIZE; color: $TEXT_COLOR; }
window { background-color: $BG_COLOR; border: 2px solid $ACCENT_COLOR; border-radius: $RADIUS; width: $w; height: $h; }
#input { margin: 10px; border: 1px solid $ACCENT_COLOR; background-color: rgba(0,0,0,0.2); color: $TEXT_COLOR; }
#entry:selected { background-color: $ACCENT_COLOR; }
#text:selected { color: $BG_COLOR; }
EOF
}

# Generate individual styles
gen_css ~/.config/wofi/main.css $MAIN_W $MAIN_H
gen_css ~/.config/wofi/power.css $POWER_W $POWER_H
gen_css ~/.config/wofi/audio.css $AUDIO_W $AUDIO_H

# Sync Niri, Alacritty, and Waybar
sed -i "s/active-color \".*\"/active-color \"${ACCENT_COLOR}ff\"/g" ~/.config/niri/config.kdl
sed -i "s/background = '#.*'/background = '$BG_COLOR'/g" ~/.config/alacritty/alacritty.toml
sed -i "s/background = '#.*' # selection/background = '$ACCENT_COLOR' # selection/g" ~/.config/alacritty/alacritty.toml
sed -i "s/@define-color bg #.*;/@define-color bg $BG_COLOR;/g" ~/.config/waybar/style.css
sed -i "s/@define-color accent #.*;/@define-color accent $ACCENT_COLOR;/g" ~/.config/waybar/style.css

echo "All modular themes applied."
#!/bin/bash
source ~/.config/globalStyle

# Function to generate individual CSS files
gen_css() {
    local file=$1; local w=$2; local h=$3; local r=$4; local f=$5; local p=$6
    cat <<EOF > "$file"
* { 
    font-family: "JetBrainsMono Nerd Font"; 
    font-size: $f; 
    color: $TEXT_COLOR; 
}
window { 
    background-color: $BG_COLOR; 
    border: 2px solid $ACCENT_COLOR; 
    border-radius: $r; 
    width: $w; 
    height: $h; 
    padding: $p;
}
#input { 
    margin: 10px; 
    border: 1px solid $ACCENT_COLOR; 
    background-color: rgba(0,0,0,0.2); 
    color: $TEXT_COLOR; 
    padding: 5px;
}
#entry:selected { 
    background-color: $ACCENT_COLOR; 
    border-radius: $r;
}
#text:selected { 
    color: $BG_COLOR; 
}
EOF
}

# 1. Generate the 3 CSS files
gen_css ~/.config/wofi/main.css $MAIN_W $MAIN_H $MAIN_ROUND $MAIN_FONT $MAIN_PADDING
gen_css ~/.config/wofi/power.css $POWER_W $POWER_H $POWER_ROUND $POWER_FONT $POWER_PADDING
gen_css ~/.config/wofi/audio.css $AUDIO_W $AUDIO_H $AUDIO_ROUND $AUDIO_FONT $AUDIO_PADDING

# 2. Sync Niri (Focus Ring/Border)
sed -i "s/active-color \".*\"/active-color \"${ACCENT_COLOR}ff\"/g" ~/.config/niri/config.kdl

# 3. Sync Alacritty (Background/Selection)
sed -i "s/background = '#.*'/background = '$BG_COLOR'/g" ~/.config/alacritty/alacritty.toml
sed -i "s/background = '#.*' # selection/background = '$ACCENT_COLOR' # selection/g" ~/.config/alacritty/alacritty.toml

# 4. Sync Waybar (Variables)
sed -i "s/@define-color bg #.*;/@define-color bg $BG_COLOR;/g" ~/.config/waybar/style.css
sed -i "s/@define-color accent #.*;/@define-color accent $ACCENT_COLOR;/g" ~/.config/waybar/style.css

echo "Themes regenerated with individual padding and rounding."
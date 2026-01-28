#!/bin/bash
source ~/.config/globalStyle

# 1. Update Wofi CSS (Modular)
cat <<EOF > ~/.config/wofi/style.css
* {
    font-family: "JetBrainsMono Nerd Font", sans-serif;
    font-size: $WOFI_FONT_SIZE;
    color: $TEXT_COLOR;
}

window {
    background-color: $BG_COLOR;
    border: $WOFI_BORDER_WIDTH solid $ACCENT_COLOR;
    border-radius: $WOFI_RADIUS;
    width: $WOFI_WIDTH;
    height: $WOFI_HEIGHT;
}

#input {
    margin: 10px;
    border: $WOFI_BORDER_WIDTH solid $ACCENT_COLOR;
    background-color: rgba(0, 0, 0, 0.2);
    color: $TEXT_COLOR;
}

#entry:selected {
    background-color: $ACCENT_COLOR; /* selection */
}

#text:selected {
    color: $BG_COLOR;
}
EOF

# 2. Update Alacritty
sed -i "s/background = '#.*'/background = '$BG_COLOR'/g" ~/.config/alacritty/alacritty.toml
sed -i "s/background = '#.*' # selection/background = '$ACCENT_COLOR' # selection/g" ~/.config/alacritty/alacritty.toml

# 3. Update Waybar
sed -i "s/@define-color bg #.*;/@define-color bg $BG_COLOR;/g" ~/.config/waybar/style.css
sed -i "s/@define-color accent #.*;/@define-color accent $ACCENT_COLOR;/g" ~/.config/waybar/style.css

# 4. Update Niri
sed -i "s/active-color \".*\"/active-color \"${ACCENT_COLOR}ff\"/g" ~/.config/niri/config.kdl

echo "Modular theme applied from globalStyle."
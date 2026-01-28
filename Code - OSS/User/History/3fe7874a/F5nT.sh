#!/bin/bash
source ~/.config/globalStyle

CHOICE=$(echo -e "󰓃  Audio Settings\n󰖩  Network Manager\n󊐵  System Monitor\n󰂯  Bluetooth\n󰐥  Power Menu" | wofi --dmenu --style ~/.config/wofi/style.css --width 600 --height 400 --location center --hide-input)

case "$CHOICE" in
    *"Audio"*) 
        # This will now trigger the device switcher
        ~/.config/scripts/audio-menu.sh ;;
    *"Network"*) 
        alacritty --title nmtui-float -e nmtui ;;
    *"System Monitor"*) 
        alacritty --title btop-float -e btop ;;
    *"Bluetooth"*) 
        alacritty --title blue-float -e blueman-tui ;;
    *"Power"*) 
        ~/.config/scripts/power-menu.sh ;;
esac
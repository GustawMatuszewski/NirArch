#!/bin/bash
source ~/.config/globalStyle

# Theme for terminal apps
export NEWT_COLORS="root=,black;window=,black;shadow=,black;button=black,white;actbutton=black,yellow;title=yellow,black;body=white,black;listbox=white,black;actlistbox=black,yellow"

# Main Menu
CHOICE=$(echo -e "󰓃  Audio Switcher\n󰖁  Volume Mixer\n󰖩  Network Manager\n󊐵  System Monitor\n󰂯  Bluetooth\n󰐥  Power Menu" | wofi --dmenu --style ~/.config/wofi/style.css --width 300 --height 320 --location center --hide-input)

case "$CHOICE" in
    *"Audio Switcher"*)
        ~/.config/scripts/audio-menu.sh ;;
    *"Volume Mixer"*)
        pavucontrol ;;
    *"Network"*)
        alacritty --title nmtui-float -e nmtui ;;
    *"System Monitor"*)
        alacritty --title btop-float -e btop ;;
    *"Bluetooth"*)
        alacritty --title blue-float -e blueman-tui ;;
    *"Power"*)
        ~/.config/scripts/power-menu.sh ;;
esac
#!/bin/bash
source ~/.config/globalStyle

# Terminal UI colors
export NEWT_COLORS="root=,black;window=,black;shadow=,black;button=black,white;actbutton=black,yellow;title=yellow,black;body=white,black;listbox=white,black;actlistbox=black,yellow"

CHOICE=$(echo -e "󰓃  Audio Settings\n󰖩  Network Manager\n󊐵  System Monitor\n󰂯  Bluetooth\n󰐥  Power Menu" | wofi --dmenu --style ~/.config/wofi/main.css --location center --hide-input)

case "$CHOICE" in
    *"Audio"*) ~/.config/scripts/audio-menu.sh ;;
    *"Network"*) alacritty --title nmtui-float -e nmtui ;;
    *"System Monitor"*) alacritty --title btop-float -e btop ;;
    *"Bluetooth"*) alacritty --title blue-float -e blueman-tui ;;
    *"Power"*) ~/.config/scripts/power-menu.sh ;;
esac
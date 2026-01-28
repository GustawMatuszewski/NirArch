#!/bin/bash
export NEWT_COLORS='root=,black;window=,black;shadow=,black;button=white,black;actbutton=black,yellow;title=white,black;body=white,black;listbox=white,black;actlistbox=black,yellow'

CHOICE=$(echo -e "󰓃  Audio Settings\n󰖩  Network Manager\n󊐵  System Monitor\n󰂯  Bluetooth\n󰐥  Power Menu" | wofi --dmenu --style ~/.config/wofi/style.css --width 300 --height 280 --location center --hide-input)

case "$CHOICE" in
    *"Audio"*) ~/.config/scripts/audio-menu.sh ;;
    *"Network"*) alacritty --title nmtui-float -e nmtui ;;
    *"System Monitor"*) alacritty --title btop-float -e btop ;;
    *"Bluetooth"*) alacritty --title blue-float -e blueman-tui ;;
    *"Power"*) ~/.config/scripts/power-menu.sh ;;
esac
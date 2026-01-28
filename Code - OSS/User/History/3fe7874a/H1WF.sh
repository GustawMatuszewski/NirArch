#!/bin/bash
source ~/.config/globalStyle
export NEWT_COLORS="root=,black;window=,black;shadow=,black;button=black,white;actbutton=black,yellow;title=yellow,black;body=white,black;listbox=white,black;actlistbox=black,yellow"

# Notice: No --width or --height here, it's all in style.css now!
CHOICE=$(echo -e "󰓃  Audio Settings\n󰖩  Network Manager\n󊐵  System Monitor\n󰂯  Bluetooth\n󰐥  Power Menu" | wofi --dmenu --style ~/.config/wofi/style.css --location center --hide-input)

case "$CHOICE" in
    *"Audio"*) ~/.config/scripts/audio-menu.sh ;;
    *"Network"*) alacritty --title nmtui-float -e nmtui ;;
    *"System Monitor"*) alacritty --title btop-float -e btop ;;
    *"Bluetooth"*) alacritty --title blue-float -e blueman-tui ;;
    *"Power"*) ~/.config/scripts/power-menu.sh ;;
esac
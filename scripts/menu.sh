#!/bin/bash
# ── Settings menu (wofi dmenu) ──

STYLE="$HOME/.config/wofi/style.css"

ENTRIES="󰓃  Audio Settings
󰖩  Network Manager
󊐵  System Monitor
󰂯  Bluetooth
󰐥  Power Menu"

CHOICE=$(echo -e "$ENTRIES" | wofi --dmenu \
    --style "$STYLE" \
    --width 300 --height 300 \
    --location center \
    --hide-search \
    --cache-file /dev/null \
    --prompt "Settings")

case "$CHOICE" in
    *"Audio"*)          ~/.config/scripts/audio-menu.sh ;;
    *"Network"*)        alacritty --title nmtui-float -e nmtui ;;
    *"System Monitor"*) alacritty --title btop-float -e btop ;;
    *"Bluetooth"*)      alacritty --title blue-float -e bluetuith ;;
    *"Power"*)          ~/.config/scripts/power-menu.sh ;;
esac

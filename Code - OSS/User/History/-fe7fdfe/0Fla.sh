#!/bin/bash
CHOICE=$(echo -e "󰐥  Shutdown\n󰜉  Reboot\n󰜺  Cancel" | wofi --dmenu --style ~/.config/wofi/style.css --width 250 --height 250 --location center --hide-search)

if [[ "$CHOICE" == *"Shutdown"* ]]; then
    systemctl poweroff
elif [[ "$CHOICE" == *"Reboot"* ]]; then
    systemctl reboot
fi
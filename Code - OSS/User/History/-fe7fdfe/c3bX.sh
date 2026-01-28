#!/bin/bash
source ~/.config/globalStyle

CHOICE=$(echo -e "󰐥  Shutdown\n󰜉  Reboot\n󰜺  Cancel" | wofi --dmenu --style ~/.config/wofi/power.css --location center --hide-input)

if [[ "$CHOICE" == *"Shutdown"* ]]; then
    systemctl poweroff
elif [[ "$CHOICE" == *"Reboot"* ]]; then
    systemctl reboot
fi
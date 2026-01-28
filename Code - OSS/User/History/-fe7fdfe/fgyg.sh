#!/bin/bash
CHOICE=$(echo -e "󰐥  Shutdown\n󰜉  Reboot\n󰜺  Cancel" | wofi --dmenu --style ~/.config/wofi/power.css --location center --hide-input)
[[ "$CHOICE" == *"Shutdown"* ]] && systemctl poweroff
[[ "$CHOICE" == *"Reboot"* ]] && systemctl reboot
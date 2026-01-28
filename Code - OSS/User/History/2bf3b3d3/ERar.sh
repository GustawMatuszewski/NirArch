#!/bin/bash

# 1. Get the Sinks block, remove symbols, and grab ID + Name
# We filter for lines that look like " 54. Name [vol: 0.50]"
MENU_OPTIONS=$(wpctl status | sed -n '/Sinks:/,/Sources:/p' | grep -E '[0-9]+\.' | sed 's/[│├─└*]//g' | awk '{$1=$1;print}')

# 2. Show the menu
CHOICE=$(echo "$MENU_OPTIONS" | wofi --dmenu --style ~/.config/wofi/style.css --width 400 --height 250 --hide-input --prompt "Select Output Device")

# 3. If the user picked something, extract the ID and set it
if [ ! -z "$CHOICE" ]; then
    # The ID is the first word (e.g., "54")
    ID=$(echo "$CHOICE" | awk '{print $1}' | tr -d '.')
    wpctl set-default "$ID"
    
    # Optional: notify you that it changed
    notify-send "Audio Output" "Switched to: $(echo $CHOICE | cut -d' ' -f2-)"
fi
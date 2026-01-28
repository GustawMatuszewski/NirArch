#!/bin/bash

# Define the first menu options
ACTIONS="󰝟  Mute / Unmute\n󰓃  Switch Output Device\n󰓇  Open Full Mixer (GUI)"

# Show the action menu
SELECT=$(echo -e "$ACTIONS" | wofi --dmenu --style ~/.config/wofi/no-input.css --width 300 --height 220 --location center --prompt "Audio Control")

case "$SELECT" in
    *"Mute"*)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        ;;
    *"Switch Output"*)
        # Second stage: Get hardware list
        MENU_OPTIONS=$(wpctl status | sed -n '/Sinks:/,/Sources:/p' | grep -E '[0-9]+\.' | sed 's/[│├─└*]//g' | awk '{$1=$1;print}')
        CHOICE=$(echo "$MENU_OPTIONS" | wofi --dmenu --style ~/.config/wofi/no-input.css --width 450 --height 250 --location center --prompt "Select Device")
        
        if [ ! -z "$CHOICE" ]; then
            ID=$(echo "$CHOICE" | awk '{print $1}' | tr -d '.')
            wpctl set-default "$ID"
        fi
        ;;
    *"Full Mixer"*)
        pavucontrol
        ;;
esac
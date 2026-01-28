#!/bin/bash

# Define the first menu options
ACTIONS="󰝟  Mute / Unmute\n󰓃  Switch Output Device\n󰓇  Open Full Mixer (GUI)"

# Show the action menu using your main style
SELECT=$(echo -e "$ACTIONS" | wofi --dmenu --style ~/.config/wofi/style.css --width 300 --height 200 --location center --hide-search --prompt "Audio Control")

case "$SELECT" in
    *"Mute"*)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        ;;
    *"Switch Output"*)
        # Get hardware list
        MENU_OPTIONS=$(wpctl status | sed -n '/Sinks:/,/Sources:/p' | grep -E '[0-9]+\.' | sed 's/[│├─└*]//g' | awk '{$1=$1;print}')
        
        # Show hardware list using your main style
        CHOICE=$(echo "$MENU_OPTIONS" | wofi --dmenu --style ~/.config/wofi/style.css --width 450 --height 250 --location center --hide-input --prompt "Select Device")
        
        if [ ! -z "$CHOICE" ]; then
            ID=$(echo "$CHOICE" | awk '{print $1}' | tr -d '.')
            wpctl set-default "$ID"
        fi
        ;;
    *"Full Mixer"*)
        pavucontrol
        ;;
esac
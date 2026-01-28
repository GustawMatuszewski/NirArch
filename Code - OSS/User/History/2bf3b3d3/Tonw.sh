#!/bin/bash

# Launch the full mixer in the background immediately
pavucontrol &

# Get the audio sinks for the quick switcher
MENU_OPTIONS=$(wpctl status | sed -n '/Sinks:/,/Sources:/p' | grep -E '[0-9]+\.' | sed 's/[│├─└*]//g' | awk '{$1=$1;print}')

# Launch the switcher menu using the no-input style
CHOICE=$(echo "$MENU_OPTIONS" | wofi --dmenu --style ~/.config/wofi/no-input.css --width 400 --height 250 --location center --prompt "Select Output")

# If a choice is made in the switcher, set it as default
if [ ! -z "$CHOICE" ]; then
    ID=$(echo "$CHOICE" | awk '{print $1}' | tr -d '.')
    wpctl set-default "$ID"
fi
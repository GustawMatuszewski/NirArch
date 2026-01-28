#!/bin/bash

# If an argument "mixer" is passed, open pavucontrol and exit
if [ "$1" == "mixer" ]; then
    pavucontrol
    exit 0
fi

# Otherwise, run the Switcher logic
MENU_OPTIONS=$(wpctl status | sed -n '/Sinks:/,/Sources:/p' | grep -E '[0-9]+\.' | sed 's/[│├─└*]//g' | awk '{$1=$1;print}')

CHOICE=$(echo "$MENU_OPTIONS" | wofi --dmenu --style ~/.config/wofi/style.css --width 400 --height 250 --hide-input --prompt "Select Output Device")

if [ ! -z "$CHOICE" ]; then
    ID=$(echo "$CHOICE" | awk '{print $1}' | tr -d '.')
    wpctl set-default "$ID"
fi
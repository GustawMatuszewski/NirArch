#!/bin/bash
source ~/.config/globalStyle

# If right-clicked or called with 'mixer', open the GUI
if [ "$1" == "mixer" ]; then
    pavucontrol
    exit 0
fi

# Switcher Logic
MENU_OPTIONS=$(wpctl status | sed -n '/Sinks:/,/Sources:/p' | grep -E '[0-9]+\.' | sed 's/[│├─└*]//g' | awk '{$1=$1;print}')

CHOICE=$(echo "$MENU_OPTIONS" | wofi --dmenu --style ~/.config/wofi/audio.css --location center --hide-input --prompt "Output Device")

if [ ! -z "$CHOICE" ]; then
    ID=$(echo "$CHOICE" | awk '{print $1}' | tr -d '.')
    wpctl set-default "$ID"
fi
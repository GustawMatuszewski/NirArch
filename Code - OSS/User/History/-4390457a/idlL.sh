#!/bin/bash

# Configuration
WALL_DIR="$HOME/.config/wallpapers"
INTERVAL=300 # Time in seconds (300 = 5 minutes)

# Ensure swww-daemon is running
if ! pgrep -x "swww-daemon" > /dev/null; then
    swww-daemon &
    sleep 1
fi

while true; do
    # Find a random image or GIF in the folder
    SELECTED_WALL=$(find "$WALL_DIR" -type f | shuf -n 1)

    # Apply the wallpaper with a smooth transition
    swww img "$SELECTED_WALL" --transition-type outer --transition-fps 60 --transition-step 10

    sleep $INTERVAL
done

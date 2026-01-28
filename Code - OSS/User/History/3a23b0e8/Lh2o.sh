#!/bin/bash

# Configuration
BAT="BAT1"
ADP="ADP1"
LOW_LEVEL=10

last_adp_status=$(cat /sys/class/power_supply/$ADP/online)

while true; do
    current_adp_status=$(cat /sys/class/power_supply/$ADP/online)
    capacity=$(cat /sys/class/power_supply/$BAT/capacity)

    # Detect Plugged In (Adapter goes from 0 to 1)
    if [[ "$current_adp_status" -eq 1 && "$last_adp_status" -eq 0 ]]; then
        notify-send -u low "󱐋 Power Connected" "System is now on AC power."
        last_adp_status=1
    fi

    # Detect Unplugged (Adapter goes from 1 to 0)
    if [[ "$current_adp_status" -eq 0 && "$last_adp_status" -eq 1 ]]; then
        notify-send -u low "󰂃 Power Disconnected" "System is now on battery."
        last_adp_status=0
    fi

    # Low Battery Alert (Only if unplugged)
    if [[ "$current_adp_status" -eq 0 && "$capacity" -le "$LOW_LEVEL" ]]; then
        notify-send -u critical "󰂃 Battery Critical" "Level: $capacity%. Plug in now!"
        sleep 120 
    fi

    sleep 2
done
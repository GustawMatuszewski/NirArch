#!/bin/bash

# Configuration
BAT="BAT1"
LOW_LEVEL=10

last_status=""

while true; do
    status=$(cat /sys/class/power_supply/$BAT/status)
    capacity=$(cat /sys/class/power_supply/$BAT/capacity)

    # Detect Status Change (Plugged/Unplugged)
    if [ "$status" != "$last_status" ]; then
        if [ "$status" == "Charging" ]; then
            notify-send -u low "󱐋 Power Connected" "Battery is now charging."
        elif [ "$status" == "Discharging" ]; then
            notify-send -u low "󰂃 Power Disconnected" "Laptop is on battery power."
        fi
        last_status="$status"
    fi

    # Low Battery Alert
    if [ "$status" == "Discharging" ] && [ "$capacity" -le "$LOW_LEVEL" ]; then
        notify-send -u critical "󰂃 Battery Critical" "Level: $capacity%. Plug in your charger!"
        sleep 60 # Don't spam critical alerts
    fi
    
    # Full Battery Alert
    if [ "$status" == "Full" ] && [ "$capacity" -eq 100 ]; then
        notify-send -u low "󰂅 Battery Full" "Charging finished."
    fi

    sleep 5
done
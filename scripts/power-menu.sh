#!/bin/bash
# ── Power menu (wofi dmenu) ──

STYLE="$HOME/.config/wofi/style.css"

ENTRIES="󰌾  Lock
󰤄  Suspend
󰜉  Reboot
󰐥  Shutdown
  Logout
󰜺  Cancel"

CHOICE=$(echo -e "$ENTRIES" | wofi --dmenu \
    --style "$STYLE" \
    --width 250 --height 340 \
    --location center \
    --hide-search \
    --cache-file /dev/null \
    --prompt "Power")

case "$CHOICE" in
    *"Lock"*)     swaylock ;;
    *"Suspend"*)  systemctl suspend ;;
    *"Reboot"*)   systemctl reboot ;;
    *"Shutdown"*) systemctl poweroff ;;
    *"Logout"*)   loginctl terminate-user "$USER" ;;
esac

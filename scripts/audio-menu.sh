#!/bin/bash
# ── Audio control menu (wofi dmenu) ──
# Opens pulsemixer TUI for full control, or quick actions via wofi

STYLE="$HOME/.config/wofi/style.css"
WOFI_COMMON="--style $STYLE --location center --cache-file /dev/null"

# ── Right-click shortcut: open TUI directly ──
if [[ "$1" == "mixer" ]]; then
    alacritty --title audio-float -e pulsemixer
    exit 0
fi

# ── Get current volume info for display ──
VOL=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null | awk '{printf "%.0f%%", $2*100}')
MUTE_STATE=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null | grep -q MUTED && echo "Unmute" || echo "Mute")

ENTRIES="󰝟  $MUTE_STATE (currently $VOL)
󰓃  Open Audio Mixer
󰋋  Switch Output Device
  Switch Input Device"

SELECT=$(echo -e "$ENTRIES" | wofi --dmenu \
    $WOFI_COMMON \
    --width 350 --height 260 \
    --hide-search \
    --prompt "Audio Control")

case "$SELECT" in
    *"ute"*)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        NEW=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null)
        if echo "$NEW" | grep -q MUTED; then
            notify-send -t 2000 "Audio" "🔇 Muted"
        else
            notify-send -t 2000 "Audio" "🔊 Unmuted — $(echo "$NEW" | awk '{printf "%.0f%%", $2*100}')"
        fi
        ;;

    *"Mixer"*)
        alacritty --title audio-float -e pulsemixer
        ;;

    *"Output"*)
        SINKS=$(wpctl status 2>/dev/null | \
            sed -n '/Audio/,/Video/p' | \
            sed -n '/Sinks:/,/^\s*$/p' | \
            grep -E '^\s+[*│├─└ ]*[0-9]+\.' | \
            sed 's/[│├─└]//g; s/^[ \t]*//' | \
            sed 's/^\*/▶ /')

        if [[ -z "$SINKS" ]]; then
            notify-send -t 3000 "Audio" "No output devices found"
            exit 1
        fi

        CHOICE=$(echo "$SINKS" | wofi --dmenu \
            $WOFI_COMMON \
            --width 500 --height 300 \
            --hide-search \
            --prompt "Output Device")

        if [[ -n "$CHOICE" ]]; then
            ID=$(echo "$CHOICE" | grep -oP '^\s*[▶ ]*\K[0-9]+')
            if [[ -n "$ID" ]]; then
                wpctl set-default "$ID"
                NAME=$(echo "$CHOICE" | sed 's/^[▶ ]*[0-9]*\.\s*//')
                notify-send -t 2000 "Audio" "Output → $NAME"
            fi
        fi
        ;;

    *"Input"*)
        SOURCES=$(wpctl status 2>/dev/null | \
            sed -n '/Audio/,/Video/p' | \
            sed -n '/Sources:/,/^\s*$/p' | \
            grep -E '^\s+[*│├─└ ]*[0-9]+\.' | \
            sed 's/[│├─└]//g; s/^[ \t]*//' | \
            sed 's/^\*/▶ /')

        if [[ -z "$SOURCES" ]]; then
            notify-send -t 3000 "Audio" "No input devices found"
            exit 1
        fi

        CHOICE=$(echo "$SOURCES" | wofi --dmenu \
            $WOFI_COMMON \
            --width 500 --height 300 \
            --hide-search \
            --prompt "Input Device")

        if [[ -n "$CHOICE" ]]; then
            ID=$(echo "$CHOICE" | grep -oP '^\s*[▶ ]*\K[0-9]+')
            if [[ -n "$ID" ]]; then
                wpctl set-default "$ID"
                NAME=$(echo "$CHOICE" | sed 's/^[▶ ]*[0-9]*\.\s*//')
                notify-send -t 2000 "Audio" "Input → $NAME"
            fi
        fi
        ;;
esac

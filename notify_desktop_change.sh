#!/bin/sh

notify_desktop_change () {
    line="$1"
    desktop_id=$(echo "$line" | cut -d ' ' -f 3)
    desktop_name=$(bspc query -D --desktop "$desktop_id" --names)
    dunstify \
        --urgency low \
        --hints string:x-dunst-stack-tag:desktop_focus \
        --timeout 750 "Desktop: $desktop_name"
}

bspc subscribe desktop_focus | while read -r line; do notify_desktop_change "$line"; done

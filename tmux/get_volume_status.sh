#!/bin/sh

is_muted="$(pactl get-sink-mute @DEFAULT_SINK@ | cut -d ' ' -f 2)"
volume="$(pactl get-sink-volume @DEFAULT_SINK@ | grep -o '[^ ]*%' | head -n 1 | sed 's/.$//')"

if [ "$is_muted" = 'yes' ] || [ "$volume" = 0 ]; then
    echo '🔇'
elif [ "$volume" -gt 0 ] && [ "$volume" -le 33 ]; then
    echo '🔈'
elif [ "$volume" -gt 33 ] && [ "$volume" -le 66 ]; then
    echo '🔉'
elif [ "$volume" -gt 66 ] && [ "$volume" -le 100 ]; then
    echo '🔊'
fi

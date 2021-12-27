#!/bin/sh

is_muted="$(pactl get-sink-mute @DEFAULT_SINK@ | cut -d ' ' -f 2)"

if [ "$is_muted" = 'yes' ]; then
    echo '🔇'
else
    echo '🔊'
fi

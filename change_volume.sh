#!/bin/sh

# Arbitrary but unique message id
msgId="991049"

volume="$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | sed 's/[^0-9]*//g')"

# Change the volume using pulseaudio
if [ "$1" = "up" ] && ! [ "$volume" = 100 ]; then
    pactl set-sink-volume @DEFAULT_SINK@ +5% > /dev/null
elif [ "$1" = "down" ]; then
    pactl set-sink-volume @DEFAULT_SINK@ -5% > /dev/null
elif [ "$1" = "mute" ]; then
    pactl set-sink-mute @DEFAULT_SINK@ toggle
fi

# Query pactl for the current volume and whether or not the speaker is muted
volume="$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | sed 's/[^0-9]*//g')"
mute="$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')"
if [ "$volume" = 0 ] || [ "$mute" = "yes" ]; then
    # Show the sound muted notification
    dunstify -a "changeVolume" -u low -i audio-volume-muted -r "$msgId" "Volume muted" 
else
    # Show the volume notification
    dunstify -a "changeVolume" -u low -i audio-volume-high -r "$msgId" \
    -h int:value:"$volume" "Volume: ${volume}%"
fi

# Play the volume changed sound
canberra-gtk-play -i audio-volume-change -d "changeVolume"

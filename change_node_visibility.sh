#!/bin/sh

window_name="$2"

for node in $(bspc query -N -n .leaf); do
    if [ "$(xprop -id "$node" | grep 'WM_CLASS' | cut -d '"' -f 2)" = "$window_name" ]; then
        if [ "$1" = "toggle" ]; then
            bspc node "$node" -g hidden
        elif [ "$1" = "hide" ]; then
            bspc node "$node" -g hidden=on
        elif [ "$1" = "show" ]; then
            bspc node "$node" -g hidden=off
        fi
        exit
    fi
done

echo "No window found with name '$window_name'"
exit 1


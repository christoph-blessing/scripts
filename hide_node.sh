#!/bin/sh

window_name="$1"

for node in $(bspc query -N -n .leaf); do
    if [ "$(xprop -id "$node" | grep 'WM_CLASS' | cut -d '"' -f 2)" = "$window_name" ]; then
        bspc node "$node" -g hidden
        exit
    fi
done

echo "No window found with name '$window_name'"
exit 1

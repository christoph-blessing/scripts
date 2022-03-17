#!/bin/sh

desktop="$1"

focused=$(bspc query -M -m focused)

bspc query -M | while read -r monitor; do
    if [ "$monitor" = "$focused" ]; then
        bspc desktop -f "${monitor}:^${desktop}"
    else
        bspc desktop -a "${monitor}:^${desktop}"
    fi
done

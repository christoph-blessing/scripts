#!/bin/sh

window_id=$(bspc query -N -n)
shotgun -i  "$window_id" - | xclip -selection clipboard -t image/png

#!/bin/bash

color_red="#fb4934"
color_blue="#458588"

bspc_desktops() {
    monitors=$(bspc query -M --names)
    focused_monitor_desktops=()
    while read -r monitor; do
        focused_monitor_desktop=$(bspc query -D -d "$monitor":focused --names)
        focused_monitor_desktops+=("$focused_monitor_desktop")
    done <<< "${monitors}"

    desktops=$(bspc query -D --names)
    buf=""
    while read -r d; do
        for monitor_desktop in "${focused_monitor_desktops[@]}"; do
            if [[ "$monitor_desktop" == "$d" ]]; then
                focused_desktop=$(bspc query -D -d focused --names)
                if [[ "$focused_desktop" == "$d" ]]; then
                    buf="${buf}%{B${color_red}} ${d} %{B-}"
                else
                    buf="${buf}%{B${color_blue}} ${d} %{B-}"
                fi
                continue 2
            fi
        done
        buf="${buf} ${d} "
    done <<< "${desktops}"

    echo "$buf"
}

#!/bin/bash

color_red="#eb4034"

bspc_desktops() {
    desktops=$(bspc query -D --names | awk '!x[$0]++')
    buf=""
    while read -r d; do
        if [[ "$(bspc query -D -d focused --names)" == "${d}" ]]; then
            buf="${buf}%{B${color_red}} ${d} %{B-}"
        else
            buf="${buf} ${d} "
        fi
    done <<< "${desktops}"

    echo "$buf"
}

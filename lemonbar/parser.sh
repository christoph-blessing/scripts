#!/bin/bash

cd "$(dirname -- "$0")" || exit

. ./common.sh

desktop="$(bspc_desktops)"

while read -r line; do
    case $line in
        DAT*)
            date="${line#???}"
            ;;
        DES*)
            desktop="${line#???}"
            ;;
        KEY*)
            keyboard_layout="${line#???}"
    esac

    echo "%{l}${date}${desktop}%{r}${keyboard_layout}"
done


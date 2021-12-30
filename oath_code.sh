#!/bin/bash

if [ "$(ykman list | wc -l)" -eq 0 ]; then
    zenity --error --text 'No yubikey found'
    exit 1
fi

account=$(ykman oath accounts list | dmenu -i)
code=$(ykman oath accounts code --single "$account" 2> /dev/null)
echo "$code" | xclip -selection c

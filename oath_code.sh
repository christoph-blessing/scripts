#!/bin/bash

if [ $(ykman list | wc -l) -eq 0 ]; then
    dunstify --hints='string:x-dunst-stack-tag:oath_code' \
        --appname='oath_code.sh' \
        'No yubikey found'
    exit 1
fi

account=$(ykman oath accounts list | dmenu)
code=$(ykman oath accounts code --single "$account" 2> /dev/null)
echo "$code" | xclip -selection c

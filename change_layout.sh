#!/bin/sh

layout=$(setxkbmap -query | awk '/layout/ {print $2}')

if [ "$layout" = 'de' ]; then
    setxkbmap us
elif [ "$layout" = 'us' ]; then
    setxkbmap de
fi

#!/bin/sh

layout=$("$SCRIPTDIR"/get_layout.sh)

if [ "$layout" = 'de' ]; then
    setxkbmap us
elif [ "$layout" = 'us' ]; then
    setxkbmap de
fi

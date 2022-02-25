#!/bin/sh

initial_state="$(dunstctl is-paused)"
initial_layout=$("$SCRIPTDIR"/get_layout.sh)

if [ "$initial_state" = 'false' ]; then
    dunstctl set-paused true
fi

if [ "$initial_layout" = 'de' ]; then
    setxkbmap us
fi

slock

if [ "$initial_state" = 'false' ]; then
    dunstctl set-paused false
fi

if [ "$initial_layout" = 'de' ]; then
    setxkbmap de
fi

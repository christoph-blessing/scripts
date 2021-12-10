#!/bin/sh

initial_state="$(dunstctl is-paused)"

if [ "$initial_state" = 'false' ]; then
    dunstctl set-paused true
fi

slock

if [ "$initial_state" = 'false' ]; then
    dunstctl set-paused false
fi

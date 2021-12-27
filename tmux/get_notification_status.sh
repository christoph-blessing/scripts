#!/bin/sh

if ! command -v dunstctl; then
    echo ''
    exit
fi

if [ "$(dunstctl is-paused)" = 'true' ]; then
    echo '#[fg=#cc241d]●#[fg=default]'
else
    echo '#[fg=#98971a]●#[fg=default]'
fi

#!/bin/sh

if ! command -v dunstctl; then
    echo ''
    exit
fi

if [ "$(dunstctl is-paused)" = 'true' ]; then
    echo '🔕'
else
    echo '🔔'
fi

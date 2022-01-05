#!/bin/sh

are_connected=$(bluetoothctl info 94:DB:56:4F:46:F9 | rg 'Connected: (yes|no)' -or '$1')

if [ "$are_connected" = 'yes' ]; then
    echo '🎧'
fi

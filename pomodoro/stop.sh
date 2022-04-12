#!/bin/sh

for file in "$SCRIPTDIR"/pomodoro/stop.d/*.sh; do
    "$file"
done

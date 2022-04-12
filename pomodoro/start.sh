#!/bin/sh

for file in "$SCRIPTDIR"/pomodoro/start.d/*.sh; do
    "$file"
done

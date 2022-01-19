#!/bin/sh

tmpdir=/tmp/pomodoro

if [ -e "$tmpdir"/is_running ]; then
    count=$(cat "$tmpdir"/current_count)
    long_break_count=$(cat "$tmpdir"/long_break_count)
    echo "$count"/"$long_break_count 🍅"
fi

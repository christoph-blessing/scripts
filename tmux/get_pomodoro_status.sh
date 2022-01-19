#!/bin/sh

tmpdir=/tmp/pomodoro

if [ -e "$tmpdir"/is_running ]; then
    count=$(cat "$tmpdir"/count)
    long_break_count=$(cat "$tmpdir"/long_break_count)
    echo "$count"/"$long_break_count 🍅"
fi

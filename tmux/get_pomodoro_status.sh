#!/bin/sh

tmpdir=/tmp/pomodoro

if [ -e "$tmpdir"/is_running ]; then
    count=$(cat "$tmpdir"/count)
    status=''
    for _ in $(seq "$count"); do
        status="$status🍅"
    done
    echo "$status"
fi

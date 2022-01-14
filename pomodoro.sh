#!/bin/sh

dur=$(($1 * 60))
long_break_count=4
tmpdir=/tmp/pomodoro

if ! [ -d "$tmpdir" ]; then
    mkdir "$tmpdir"
fi

if [ -e "$tmpdir"/count ]; then
    old_count=$(cat "$tmpdir"/count)
    new_count=$((old_count + 1))
    echo "$new_count" > "$tmpdir"/count
else
    echo 1 > "$tmpdir"/count
fi

touch "$tmpdir"/is_running
trap 'rm -f -- "$tmpdir"/is_running' EXIT

dunstctl set-paused true
sleep "$dur"
dunstctl set-paused false

if [ "$new_count" = "$long_break_count" ]; then
    dunstify --hints string:x-dunst-stack-tag:pomodoro_finished "Take a long break"
    rm "$tmpdir"/count
else
    dunstify --hints string:x-dunst-stack-tag:pomodoro_finished "Take a break"
fi

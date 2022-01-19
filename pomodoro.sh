#!/bin/sh

dur=$(($1 * 60))
long_break_count=4
tmpdir=/tmp/pomodoro

if ! [ -d "$tmpdir" ]; then
    mkdir "$tmpdir"
fi

if [ ! -e "$tmpdir"/current_count ]; then
    echo 0 > "$tmpdir"/current_count
fi

echo "$long_break_count" > "$tmpdir"/long_break_count

old_count=$(cat "$tmpdir"/current_count)
if [ "$old_count" -ge "$long_break_count" ]; then
    old_count=0
fi
new_count=$((old_count + 1))
echo "$new_count" > "$tmpdir"/current_count

touch "$tmpdir"/is_running
trap 'rm -f -- "$tmpdir"/is_running' EXIT

dunstctl set-paused true
sleep "$dur"
dunstctl set-paused false

if [ "$new_count" = "$long_break_count" ]; then
    dunstify --hints string:x-dunst-stack-tag:pomodoro_finished "Take a long break"
else
    dunstify --hints string:x-dunst-stack-tag:pomodoro_finished "Take a break"
fi

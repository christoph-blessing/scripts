#!/bin/sh -e

tmpdir=/tmp/pomodoro

cleanup() {
    "$SCRIPTDIR"/pomodoro/stop.sh
    rm -f "$tmpdir"/is-running
}

trap cleanup EXIT

dur=$(($1 * 60))
long_break_count=4

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

"$SCRIPTDIR"/pomodoro/start.sh

touch "$tmpdir"/is_running
echo 0 > "$tmpdir"/elapsed_time
while [ -e "$tmpdir"/is_running ]; do
    sleep 1
    elapsed_time=$(($(cat "$tmpdir"/elapsed_time) + 1))
    if [ "$elapsed_time" -ge "$dur" ]; then
        rm "$tmpdir"/is_running
    fi
    echo "$elapsed_time" > "$tmpdir"/elapsed_time
done

"$SCRIPTDIR"/pomodoro/stop.sh

if [ "$new_count" = "$long_break_count" ]; then
    dunstify --hints string:x-dunst-stack-tag:pomodoro_finished "Take a long break"
else
    dunstify --hints string:x-dunst-stack-tag:pomodoro_finished "Take a break"
fi

#!/bin/bash

cd "$(dirname -- "$0")" || exit

. ./common.sh

font=$(fc-match monospace)

fifo=${XDG_RUNTIME_DIR:-/tmp}/lemonbar.fifo
test -e "$fifo" || mkfifo "$fifo"

trap 'pkill lemonbar; kill $(jobs -p)' EXIT

bspc subscribe desktop_focus | while read -r _; do
    echo "DES$(bspc_desktops)" > "$fifo"
done &

while :; do
    date '+DAT%H:%M %y-%m-%d' > "$fifo"
    sleep 1
done &

while :; do
    echo "KEY$(setxkbmap -query | awk '/layout/ {print $2}')" > "$fifo"
    sleep 0.1
done &

tail -f "$fifo" | "$(dirname -- "$0")"/parser.sh | lemonbar -p -f "$font"

#!/bin/sh

dur=$(($1 * 60))

dunstctl set-paused true
sleep "$dur"
dunstctl set-paused false
dunstify --hints string:x-dunst-stack-tag:pomodoro_finished "Take a break"

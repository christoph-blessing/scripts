#!/bin/sh

window_id=$(xwininfo | grep 'Window id' | cut -d ' ' -f 4)
shotgun -i  "$window_id" "$@"

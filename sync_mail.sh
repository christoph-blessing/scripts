#!/bin/bash

mbsync --config ~/.config/mbsync/mbsyncrc --all

prefix="$XDG_DATA_HOME/mail/"

for acc in "$prefix"*; do
    new_count=$(find  "$acc"/inbox/new -type f -newer ~/.config/neomutt/last-mail-sync 2> /dev/null | wc -l)
    if [ "$new_count" -gt "0" ]; then
        dunstify --hints string:x-dunst-stack-tag:sync_mail "New Mail (${acc#"$prefix"})"
    fi
done

touch ~/.config/neomutt/last-mail-sync

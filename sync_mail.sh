#!/bin/sh

mbsync --config ~/.config/mbsync/mbsyncrc --all

prefix="$XDG_DATA_HOME/mail/"

for acc_path in "$prefix"*; do
    new_count=$(find  "$acc_path"/inbox/new -type f -newer ~/.config/neomutt/last-mail-sync 2> /dev/null | wc -l)
    if [ "$new_count" -gt '0' ]; then
        acc_name="${acc_path#"$prefix"}"
        action=$(dunstify --action open,'Open Mutt' --hints string:x-dunst-stack-tag:new_mail_"$acc_name" "New Mail ($acc_name)")
        if [ "$action" = 'open' ]; then
            st -e neomutt -f +"$acc_name"/inbox
        fi
    fi
done

touch ~/.config/neomutt/last-mail-sync

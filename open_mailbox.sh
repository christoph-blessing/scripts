#!/bin/sh

mailboxes=$(fd --type d --maxdepth 2 . "$MAILDIR")
mailbox=$(echo "$mailboxes" | dmenu)

if [ -z "$mailbox" ]; then
    exit
fi

if [ "$(dirname "$mailbox")" = "$MAILDIR" ]; then 
    st -e neomutt -f "$mailbox"/inbox
else
    st -e neomutt -f "$mailbox"
fi

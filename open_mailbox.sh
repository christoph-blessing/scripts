#!/bin/sh

mailboxes=$(fd --base-directory "$MAILDIR" --strip-cwd-prefix --exclude '*/inbox/' --type d --maxdepth 2 .)
mailbox=$(echo "$mailboxes" | dmenu)

if [ -z "$mailbox" ]; then
    exit
fi

if test "${mailbox#*/}" != "$mailbox"; then 
    st -e neomutt -f +"$mailbox"
else
    st -e neomutt -f +"$mailbox"/inbox
fi

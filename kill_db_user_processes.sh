#!/bin/sh

stmts=$(mysql --execute "Select concat('KILL ',id,';') from information_schema.processlist where user='$1';" --skip-column-names)
echo "$stmts" | while read -r stmt; do
    mysql --execute "$stmt"
done

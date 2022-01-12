#!/bin/sh
set -e

db_server=$1
user=$2

old_grants=$(ssh "$db_server" "mysql --execute \"SHOW GRANTS FOR '$user'@'%'\"" | tail -n +3)
new_grants=$(echo "$old_grants" | sed --regexp-extended 's/(GRANT ).*( ON)/\1SELECT\2/g; s/`/\\\`/g; s/$/\;/g')

sql="REVOKE ALL PRIVILEGES, GRANT OPTION FROM '$user'@'%'; $new_grants"

ssh "$db_server" "mysql --execute \"$sql\""

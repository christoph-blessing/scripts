#!/bin/sh
set -e

db_server=$1
user=$2
password=$(keepassxc-cli diceware --quiet --words 4)

ssh "$db_server" "mysql --execute \"CREATE USER '$user'@'%' IDENTIFIED BY '$password';\n
GRANT ALL PRIVILEGES ON \\\`$user\\_%\\\`.* TO '$user'@'%' WITH GRANT OPTION;\n
GRANT ALL PRIVILEGES ON \\\`nnfabrik\\_$user\\_%\\\`.* TO '$user'@'%';\"" > /dev/null

db_server_ip=$(ssh -G "$db_server" | awk '/^hostname / { print $2 }')

xclip -selection c << EOF
Database Server Credentials:
host: '$db_server_ip'
user: '$user'
password: '$password'

How to connect:
https://docs.datajoint.org/python/setup/01-Install-and-Connect.html

You have full privileges on schemas that start with '${user}_'.
EOF

#!/bin/sh
set -e

db_server=$1
user=$2
password=$(keepassxc-cli diceware --quiet --words 4)

ssh "$db_server" "mysql --execute \"CREATE USER '$user'@'%' IDENTIFIED BY '$password';\n
GRANT ALL PRIVILEGES ON \\\`$user\\_%\\\`.* TO '$user'@'%';\n
GRANT ALL PRIVILEGES ON \\\`nnfabrik\\_$user\\_%\\\`.* TO '$user'@'%';\"" > /dev/null

xclip -selection c << EOF
Database Server Credentials:
host: '$db_server'
user: '$user'
password: '$password'

How to connect:
https://docs.datajoint.org/python/setup/01-Install-and-Connect.html

You have full privileges on schemas that start with '${user}_'.
EOF

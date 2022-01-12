#!/bin/sh
set -e

db_server=$1
user=$2
password=$(keepassxc-cli diceware --quiet --words 4)

ssh "$db_server" "mysql --execute \"CREATE USER '$user'@'%' IDENTIFIED BY '$password';\n
GRANT ALL PRIVILEGES ON \\\`$user\\_%\\\`.* TO '$user'@'%';\n
GRANT ALL PRIVILEGES ON \\\`nnfabrik\\_$user\\_%\\\`.* TO '$user'@'%';\"" > /dev/null

echo "Username: '$user'; Password: '$password'" | xclip -selection c

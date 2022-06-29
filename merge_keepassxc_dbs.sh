#!/bin/sh
set -e

local_db="$XDG_DATA_HOME"/keepassxc/Passwords.kdbx
android_db="$HOME"/mnt/Internal\ shared\ storage/Documents/Passwords.kdbx

mountpoint "$HOME"/mnt || (mount.jmtpfs "$HOME"/mnt && trap 'umount $HOME/mnt' EXIT)

keepassxc-cli merge --yubikey 2 --same-credentials "$local_db" "$android_db"
cp "$local_db" "$android_db"

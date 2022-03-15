#!/bin/sh

remote_path="$1"

directory_names=$(rclone lsd "$remote_path" | awk '{print $5}')

echo 'path,object count,size (bytes)'
echo "$directory_names" | while read -r directory_name; do
    directory_path="${remote_path}/${directory_name}"

    output=$(rclone size "$directory_path")
    count=$(echo "$output" | awk 'NR==1{print $4}' | tr -d '()')
    size=$(echo "$output" | awk 'NR==2{print $5}' | tr -d '(')
    echo "${directory_path},${count},${size}"
done

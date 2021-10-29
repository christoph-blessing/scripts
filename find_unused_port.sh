#!/bin/bash

read lower_port upper_port < /proc/sys/net/ipv4/ip_local_port_range
while true; do
    port=$(shuf -i "$lower_port"-"$upper_port" -n 1)
    ss -tulpn | grep :"$port" > /dev/null || break
done

echo "$port"

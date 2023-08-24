#!/usr/bin/env bash

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi

myhostname=$(cat /etc/hostname)

hosts=(
    "127.0.0.1		localhost"\
    "::1		localhost"\
    "127.0.1.1		$myhostname"\
)

for host in ${hosts[@]}; do
    sed -i "$host" /etc/hosts
done
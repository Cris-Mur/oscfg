#!/usr/bin/env bash

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi

zoneinfo="/usr/share/zoneinfo"

region=$1

city=$2

if ![ -d "$zoneinfo/$region" ]; then
    echo "Usage a valid Region"
    regions=$(find "$zoneinfo" -maxdepth 1 -type f -exec basename {} \;)
    output=""
    for land in $regions; do
        output="$output | $land"
    done
    echo "$output"
    exit 1;
fi

if ![ -f "$zoneinfo/$region/$city" ]; then
    echo "Usage a valid Region/city"
    cities=$(find "$zoneinfo/$region/$city" -maxdepth 1 -type f -exec basename {} \;)
    output=""
    for land in $cities; do
        output="$output | $land"
    done
    echo "$output"
    exit 1;
fi

ln -sf "$zoneinfo/$region/$city" /etc/localtime
hwclock --systohc
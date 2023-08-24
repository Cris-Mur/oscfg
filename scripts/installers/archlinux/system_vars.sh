#!/usr/bin/env bash

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi

read -p "Input host name: " hostname
echo "$hostname" > /etc/hostname
echo "LANG=es_CO.UTF-8" > /etc/locale.conf
echo "KEYMAP=us-latin1" > /etc/vconsole.conf
#!/usr/bin/env bash

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root.";
    exit 1;
fi

if [ ! -f "/etc/hosts" ]; then
    echo "host file not found.";
    exit 1;
fi

whoami=$(cat /etc/hostname);

hosts_ "-a" "localhost" "127.0.0.1"
hosts_ "-a" "$whoami" "127.0.0.1"

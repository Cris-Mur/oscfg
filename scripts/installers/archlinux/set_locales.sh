#!/usr/bin/env bash

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi

enable-locale en_US.UTF-8 es_CO.UTF-8 ja_JP.UTF-8
locale-gen
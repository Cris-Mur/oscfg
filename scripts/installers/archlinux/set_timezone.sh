#!/usr/bin/env bash

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root.";
    exit 1;
fi

timezone_ --set America Bogota
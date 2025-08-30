#!/usr/bin/env bash

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi

function get_default_host() {
    local machine=$(hostnamectl | grep -w "Hardware Model")
    local pattern="Hardware Model: "
    machine=${machine#pattern}
    echo -e $machine
}

function set_hostname() {
    read -p "Use Default host name? (S/n): > " default
    if [ $default == "s" ] || [ $default == "S" ]; then
        local hostname=$(get_default_host);
        echo $hostname
    else
        read -p "Input host name: " hostname
    fi
}

if [ ! -f "/etc/hostname" ]; then
    hostname=$(set_hostname)
else
    echo -e "hostname already set, you want overwrite? (S/n)"
    read -p "> " answer
    if [ $answer == "s" ] || [ $answer == "S" ]; then
        echo "your response $answer"
        hostname=$(set_hostname)
        echo "uwu: $hostname"
    else
        exit 0;
    fi
fi
#echo "$hostname" > /etc/hostname
bat /etc/hostname
#echo "KEYMAP=us-latin1" > /etc/vconsole.conf
bat /etc/vconsole.conf
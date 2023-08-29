#!/usr/bin/env bash

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root.";
    exit 1;
fi

usage="$0: [region/(zone/city)/] or [region] [zone/city]"

zoneinfo="/usr/share/zoneinfo";

localtime="/etc/localtime"

function print_dir_content() {
    local _dir_=$1;
    local _inner_content=$(ls $_dir_);
    local output="";
    local separator=false;
    for content in $_inner_content; do
        if $separator; then
            output+=" | $content";
        else
            separator=true;
            output+="$content";
        fi
        
    done
    echo -e "$output";
}

function set_localtime() {
    local origin=$1;
    if [ -f $localtime ]; then
        echo "Local time already set you want over write? (S/n)."
        read -p "> " answer;
        if [ $answer != 'S' ]; then
            exit 0;
        else
            rm -rf $localtime;
        fi 
    fi
    ln -sf "$origin" "$localtime"
}

function full_path_region() {
    local zone_path;
    if [ -f "$zoneinfo/$zone_path" ]; then
        set_localtime "$zoneinfo/$zone_path";
    else
        echo -e "Use valid Zone path."
        print_dir_content $zoneinfo;
        echo $usage;
        exit 1;
    fi
}

function split_path_region() {
    local region=$1;
    local city=$2;

    if [ ! -d "$zoneinfo/$region" ]; then
        echo "Usage a valid Region:";
        print_dir_content $zoneinfo;
        echo $usage;
        exit 1;
    fi

    if [ ! -f "$zoneinfo/$region/$city" ]; then
        echo "Usage a valid Region/city:";
        print_dir_content "$zoneinfo/$region/"
        echo $usage;
        exit 1;
    fi
}

if [ $# -gt 0 ] && [ $# -lt 2 ]; then
    full_path_region $1
fi

if [ $# -gt 1 ] && [ $# -lt 3 ]; then
    split_path_region $1 $2
else
    echo -e "$usage"
    exit 1;
fi

hwclock --systohc
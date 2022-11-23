#!/bin/env bash
if [ $# -eq 0 ]
then
    echo "Usage: largest_file [Path to evaluate] [Number of files that you list]"
fi

if [ -z "$2" ]
then
    echo 'default output 20 Lines'
    $2 = 20
fi

sudo du -aBm $1 2>/dev/null | sort -nr | head -n $2

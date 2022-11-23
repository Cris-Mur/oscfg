#!/bin/env bash
if [ $# -eq 0 ]
then
    echo "Usage: largest_file [Path to evaluate] [Number of files that you list]"
    exit
fi

NLINES=20
if [ -z "$2" ]
then
    echo 'default output 20 Lines'
else
    NLINES="$2"
fi

du -aBm $1 2>/dev/null | sort -nr | head -n $NLINES 

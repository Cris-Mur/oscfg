#!/usr/bin/env bash


usage() {
    if [ -x /usr/bin/bat ]; then
        bat --style=plain,grid -f "$SCRIPT_DIR/misc/help" -l Manpage
    elif [ -x /usr/bin/less ]; then
        less "$SCRIPT_DIR/misc/help"; 
    else 
        cat "$SCRIPT_DIR/misc/help";
    fi
    exit 1
}



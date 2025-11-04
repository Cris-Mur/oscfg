#!/usr/bin/env bash

profile () {
    echo "profile $@"
    case "$1" in
        status) echo -e "${BRIGHT_YELLOW}${@:2}${RESET}" ;;
        fix) echo -e "${BRIGHT_YELLOW}${@:2}${RESET}" ;;
        install) echo -e "${BRIGHT_YELLOW}${@:2}${RESET}" ;;
        uninstall) echo -e "${BRIGHT_YELLOW}${@:2}${RESET}" ;;
        snapshot) echo -e "${BRIGHT_RED}${@:2}${RESET}" ;;
        -h | --help | h | help) usage ;;
        *) usage ;;
    esac
}




#!/usr/bin/env bash

version () {
    local OSCFG_VERSION="0.1a-0.1"
    local VERBOSE_VERSION="alpha"
    local LICENCE="OSCFG-LTS"
    local cmd="[ ${BRIGHT_CYAN}$0 ${RESET}]"
    local ver="[${BRIGHT_YELLOW} Version: $OSCFG_VERSION ${RESET}]"
    local lvl="[${GREEN} $VERBOSE_VERSION ${RESET}]"
    local lic="[ Licence: ${BRIGHT_MAGENTA}$LICENCE ${RESET}]"
    echo -e "$cmd$ver$lvl$lic"
}



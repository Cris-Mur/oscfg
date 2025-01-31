#!/bin/bash

########################################################################
## Arch Pre-Instalation Script  ########################################
########################################################################

UTILS="src/basic_installation/utils"
BASIC_INSTALLATION_SCRIPTS="src/basic_installation"

pause(){
    read -p "Presione ENTER para continuar..."
}

manage_timedate() {
    source $UTILS/ask_yes_no.sh
    echo ""
    echo "Por favor verifique si la maquina usa la sincronizacion NTP."
    echo ""
    timedatectl
    response=$(ask_yes_no "¿Es correcta la configuración?" "y")

    if [[ ! "$response" =~ ^[yY]$ ]]; then
        $BASIC_INSTALLATION_SCRIPTS/enable_ntp.sh
    fi
    pause
}

root_checker() {
    # Verifica si el usuario tiene permisos de root (requerido para obtener información completa)
    if [[ $EUID -ne 0 ]]; then
        echo "❌ Este script debe ejecutarse como root o con sudo."
        exit 1
    fi
}

# TODO
    ## Manage Storage System PARTITIONS
    ## Curl to https://archlinux.org/mirrorlist/?country=CO&country=JP&country=MX&country=US&protocol=http&protocol=https&ip_version=4
    ## set mirrorlist
    ## pacstrap installation

main_script (){
### Script runing
    clear
    manage_timedate
    clear
    $BASIC_INSTALLATION_SCRIPTS/manage_storage.sh
}

main_script

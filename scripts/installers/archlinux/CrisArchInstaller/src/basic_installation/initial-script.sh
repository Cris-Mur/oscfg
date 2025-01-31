#!/bin/bash

########################################################################
## Arch Pre-Instalation Script  ########################################
########################################################################

UTILS="src/basic_installation/utils"
BASIC_INSTALLATION_SCRIPTS="src/basic_installation"

manage_timedate() {
    source $UTILS/ask_yes_no.sh
    echo ""
    echo "Por favor verifica que la maquina usa la sincronizacion NTP."
    echo ""
    timedatectl
    response=$(ask_yes_no "¿Es correcta la configuración?" "y")

    # Tomar acción según la respuesta
    if [[ "$response" =~ ^[yY]$ ]]; then
        echo "✅ Continuando con la instalación..."
    else
        $BASIC_INSTALLATION_SCRIPTS/enable_ntp.sh
    fi

}

# TODO
    ## Manage Storage System PARTITIONS
    ## Curl to https://archlinux.org/mirrorlist/?country=CO&country=JP&country=MX&country=US&protocol=http&protocol=https&ip_version=4
    ## set mirrorlist
    ## pacstrap installation

### Script runing
manage_timedate
$UTILS/disc_detector.sh
$BASIC_INSTALLATION_SCRIPTS/manage_storage.sh

# Verifica si el usuario tiene permisos de root (requerido para obtener información completa)
if [[ $EUID -ne 0 ]]; then
    echo "❌ Este script debe ejecutarse como root o con sudo."
    exit 1
fi

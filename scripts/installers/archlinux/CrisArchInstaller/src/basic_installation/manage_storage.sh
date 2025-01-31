#!/bin/bash

UTILS="src/basic_installation/utils"

pause(){
    read -p "Presione ENTER para continuar..."
    tput cuu1 && tput el
}
echo "##########################################################################"
echo "ATENCION: Tenga en cuenta que el sistema de archivos a instalar debe"
echo "cumplir con la disposición de almacenamiento de ejemplo según la WIKI de"
echo "Arch literal 1.9.1 claramente dependiendo de las caracteristicas del"
echo "sistema deseado."
echo "##########################################################################"
echo ""
echo "ROOT: / /mnt"
echo ""
echo "La Raíz del sistema normalmente es una partición de un dispositivo de"
echo "Almacenamiento que es montado en la carpeta mnt en el ArchISO"
pause
echo ""
echo "BOOT: /boot /mnt/boot"
echo ""
echo "Dependiendo del tipo de maquina que va a usar hay ciertas caracteristicas"
echo "que son importantes de determinar."
echo "En el caso de tener una maquina con un BOOT dual o con una partición"
echo "especial para gestionar el arranque o booteo de la maquina es importante"
echo "verificar que esta este correctamente montada en el sistema."
pause
echo ""
echo "[SWAP] /dev/**"
echo ""
echo "En ciertos sistemas es de utilidad tener habilitado el sistema SWAP, este"
echo "es un dispositivo o partición de almacenamiento destinado para este fin."
echo "Vease mayor información del sistema SWAP en la WIKI."
echo "https://wiki.archlinux.org/title/Swap"
echo ""
pause
echo ""
echo "Tenga en cuenta que si lo desea puede separar el sistema de archivos del"
echo "usurario en una particion independiente."
echo ""
echo "HOME: /home /mnt/home"
echo ""
pause
echo "##########################################################################"
echo "##########################################################################"
check_mnt(){
    echo "Verificando los puntos de montaje canonicos"
    EXPECTED_FS_TYPE="ext4"
    MOUNT_POINT="/mnt"
    FS_TYPE=$(findmnt -n -o FSTYPE "$MOUNT_POINT" 2>/dev/null)
}
$UTILS/disc_detector.sh

#!/bin/bash

# Configuración de la ruta de los recursos
RESOURCE_DIR="rsrcs"
SPLASH_FILE="$RESOURCE_DIR/splash.txt"
ALTERNATIVE_SPLASH_FILE="$RESOURCE_DIR/alternative_splash.txt"

BASIC_INSTALL_SCRIPT="src/basic_installation/initial-script.sh"

pause(){
    read -p "Presione ENTER para continuar..."
    tput cuu1 && tput el
}

# Función para mostrar el splash screen
show_splash() {
    if [ -f "$SPLASH_FILE" ]; then
        cat "$SPLASH_FILE"
    else
        echo "⚠ Splash screen no encontrado en $SPLASH_FILE ⚠"
    fi
    echo ""
}

show_alternative_splash() {
    if [ -f "$ALTERNATIVE_SPLASH_FILE" ]; then
        echo -e "$(cat "$ALTERNATIVE_SPLASH_FILE")"
    else
        echo "⚠ Splash screen no encontrado en $ALTERNATIVE_SPLASH_FILE ⚠"
    fi
    echo ""
}
# Funciones simuladas para cada opción del menú
basic_installation() {
    echo "⚠️ Iniciando instalación básica..."
    sleep 1
    echo "###############################################################"
    "$BASIC_INSTALL_SCRIPT"
    echo "###############################################################"
    echo "✅ Proceso terminado... Hasta pronto ( ^ _ ^ )/"
}

install_graphic_drivers() {
    echo "🎮 Instalando drivers gráficos..."
    sleep 2
    echo "✅ Drivers gráficos instalados."
}

install_desktop_environment() {
    echo "🖥 Instalando entorno de escritorio..."
    sleep 2
    echo "✅ Entorno de escritorio instalado."
}

use_neofetch() {
    if ! command -v neofetch >/dev/null 2>&1; then
        pacman -Sqy --noconfirm neofetch
    fi
    neofetch 
    return 0
}

show_about() {
    RED='\033[0;31m'
    YELLOW='\033[0;33m'
    PURPLE='\033[0;35m'
    GREEN='\033[0;32m'
    NC='\033[0m'       # Reset (color por defecto)

    clear
    echo "Este instalador esta hecho con amor para facilitar y automatizar"
    echo "la instalación de un Sistema Arch en una maquina X86-64, brindando una"
    echo "interfaz explicativa y amigable con el usuario."
    echo "Este instalador fue construido siguiendo la guia de instalación"
    echo "que se encuentra en la pagina de la WIKI de Arch."
    echo "https://wiki.archlinux.org/title/Installation_guide"
    echo "por el momento se entiende que usted es un usuario con los conocimientos"
    echo "suficientes para comprender de fondo que es lo que este programa HACE."
    echo "Aunque pretendo explicar de cierta manera la guía de instalación..."
    echo -e "${RED}NO SOY RESPONSABLE DE COMO ESTE PROGRAMA PUEDE AFECTAR A SU MAQUINA${NC}"
    echo "Ya que yo hice este programa teniendo en cuenta las caracteristicas"
    echo "propias de mis necesidades a la hora de instalar Arch como mi sistema"
    echo "Asi mismo entiende que este programa sera ejecutado en una version"
    echo "LIMPIA de la ArchISO."
    echo "Usted puede seguir los pasos previos a la instalación que son"
    echo "descritos en la guía, para garantizar que el programa funcione como es"
    echo "esperado, sin embargo este realiza la pre-instalación."
    echo -e "💻 Autor: ${PURPLE}@${GREEN}Cris-Mur${NC}"
    echo -e "Versión: ${YELLOW}0.1${NC}"
}

# Función para mostrar el menú y manejar las opciones
show_menu() {
    while true; do
        show_splash
        echo "###############################################################"
        echo "# Instalador de Sistema ⚙️ ####################################"
        echo "###############################################################"
        echo "1. Basic Installation"
        echo "2. Graphic Driver Installer"
        echo "3. Desktop Environment Installer"
        echo "4. About"
        echo "0. Exit"
        echo "###############################################################"
        read -p "Seleccione una opción: " OPTION
        
        case $OPTION in
            1) basic_installation ;;
            2) install_graphic_drivers ;;
            3) install_desktop_environment ;;
            4) show_about ;;
            0) echo " ❌ Saliendo..."; exit 0 ;;
            *) echo "# ❌ Opción no válida. Intente de nuevo. ####" ;;
        esac

        show_alternative_splash
        read -p "Presione Enter para continuar..."
        clear
    done
}

# Ejecución del programa.
#
clear
setfont ter-120b
show_about
pause
clear
show_menu


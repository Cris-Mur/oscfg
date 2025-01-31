#!/bin/bash

# Configuración de la ruta de los recursos
RESOURCE_DIR="rsrcs"
SPLASH_FILE="$RESOURCE_DIR/splash.txt"
ALTERNATIVE_SPLASH_FILE="$RESOURCE_DIR/alternative_splash.txt"

BASIC_INSTALL_SCRIPT="src/basic_installation/initial-script.sh"

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
    ## sleep 2
    echo "###############################################################"
    "$BASIC_INSTALL_SCRIPT"
    echo "###############################################################"
    echo "✅ Instalación básica completada."
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

show_about() {
    clear
    echo "Este instalador esta hecho con amor para facilitar y automatizar"
    echo "la instalación de un Sistema Arch en una maquina X86."
    echo "Este instalador fue construido siguiendo la guia de instalación"
    echo "que se encuentra en la pagina de Arch."
    echo "https://wiki.archlinux.org/title/Installation_guide"
    echo "‍💻 Autor: @Cris-Mur"
    echo "Versión: 0.1"
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

# Ejecutar el script
clear
show_menu


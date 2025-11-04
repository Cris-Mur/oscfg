#!/usr/bin/env bash


reload_shell() {
    # Forzar recarga del script maestro en la shell actual
    echo -e "$ENABLED"
    
    install_dotFiles_folder $ENABLED

    echo "🔄 Configuración recargada"
}




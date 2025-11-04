#!/usr/bin/env bash


enable_module() {
    local module="$1"
    if [ ! -d "$AVAILABLE/$module/" ]; then
        echo "❌ No existe módulo: $AVAILABLE/$module"
        exit 1
    fi
    if [ ! -e $ENABLED ]; then
        mkdir -p $ENABLED;
    fi
    ln -sf "$AVAILABLE/$module" "$ENABLED/$module"
    echo "✔ Activado: $module"
}



#!/usr/bin/env bash


disable_module() {
    local module="$1"
    if [ -L "$ENABLED/$module" ]; then
        rm "$ENABLED/$module"
        echo "✖ Desactivado: $module"
    else
        echo "❌ El módulo no estaba activado: $module"
    fi
}



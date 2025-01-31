#!/bin/bash

echo "Dispositivos de almacenamiento detectados:"
echo "------------------------------------------"

lsblk -l -o NAME,VENDOR,MODEL,PATH,UUID,SIZE,MOUNTPOINT,MODE

echo ""
echo "✅ Detección completada."

# Verifica si el usuario tiene permisos de root (requerido para obtener información completa)
if [[ $EUID -ne 0 ]]; then
    echo "❌ Este script debe ejecutarse como root o con sudo."
    exit 1
fi

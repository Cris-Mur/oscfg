#!/usr/bin/env bash

# Uso: ./este_script.sh 470

NVIDIA_DRIVER=$1
INSTALLED_VERSION=""

function verificar_argumento() {
  if [[ -z "$NVIDIA_DRIVER" ]]; then
    echo -e "❌ Debes proporcionar la versión del driver NVIDIA como argumento.\nEjemplo: $0 470"
    exit 1
  fi
}

function listar_drivers_instalados() {
  echo -e "\n🔍 Verificando drivers NVIDIA instalados..."

  local YELLOW='\033[1;33m'
  local GREEN='\033[1;32m'
  local NC='\033[0m'

  INSTALLED_PACKAGES=$(pacman -Q | grep -E 'nvidia-[0-9]+xx')

  if [[ -n "$INSTALLED_PACKAGES" ]]; then
    echo -e "✅ Drivers NVIDIA detectados:\n"

    while read -r line; do
      NAME=$(echo "$line" | awk '{print $1}')
      VERSION=$(echo "$line" | awk '{print $2}')
      echo -e "$NAME ${YELLOW}$VERSION${NC}"
    done <<< "$INSTALLED_PACKAGES"

    INSTALLED_VERSION=$(echo "$INSTALLED_PACKAGES" | grep -Eo 'nvidia-[0-9]+xx-utils [^ ]+' | head -n1 | awk '{print $1}' | grep -oP '\d+(?=xx-utils)')
    echo -e "\n🔢 Versión detectada (de xx-utils):${GREEN}$INSTALLED_VERSION${NC}\n"
  else
    echo -e "ℹ No se detectaron drivers NVIDIA instalados (formato nvidia-xxxxx).\n"
  fi
}

function comparar_version() {
  if [[ "$INSTALLED_VERSION" == "$NVIDIA_DRIVER" ]]; then
    echo "✅ La versión actual ya es la $NVIDIA_DRIVER. No se requiere instalación."
    exit 0
  fi
}

function confirmar_reemplazo() {
  read -p "¿Deseas reemplazar la versión actual por NVIDIA $NVIDIA_DRIVER? [s/N]: " confirm
  if ! [[ "$confirm" =~ ^[sS]$ ]]; then
    echo -e "\n❌ Operación cancelada por el usuario."
    exit 0
  fi
  desinstalar_drivers
}

function instalar_paquetes() {
  echo -e "\n🚀 Instalando paquetes NVIDIA versión $NVIDIA_DRIVER...\n"

  MHWD="mhwd-nvidia-${NVIDIA_DRIVER}xx"
  LIB32_OPENCL="lib32-opencl-nvidia-${NVIDIA_DRIVER}xx"
  LIB32="lib32-nvidia-${NVIDIA_DRIVER}xx-utils"
  OPENCL="opencl-nvidia-${NVIDIA_DRIVER}xx"
  NV_SETTINGS="nvidia-${NVIDIA_DRIVER}xx-settings"
  NV_UTILS="nvidia-${NVIDIA_DRIVER}xx-utils"
  NV_DRIVER="nvidia-${NVIDIA_DRIVER}xx-dkms"

  echo "📦 Paquetes a instalar:"
  echo -e "$MHWD\n$LIB32\n$OPENCL\n$LIB32_OPENCL\n$NV_SETTINGS\n$NV_DRIVER\n$NV_UTILS\n"

  yay -S $MHWD $LIB32 $OPENCL $LIB32_OPENCL $NV_SETTINGS $NV_DRIVER $NV_UTILS

  echo -e "\n✅ Instalación completada."
}

function desinstalar_drivers() {
    local YELLOW='\033[1;33m'
    local GREEN='\033[1;32m'
    local NC='\033[0m'

    echo -e "\n❗ ${YELLOW}Desinstalando paquetes NVIDIA antiguos...${NC}"
    echo -e "🔢 Versión detectada: ${YELLOW}${INSTALLED_VERSION:-Desconocida}${NC}\n"

    # Leer paquetes en array correctamente, una línea por elemento
    IFS=$'\n' read -rd '' -a INSTALLED_NVIDIA_PKGS < <(
        pacman -Q | grep -E '^((mhwd-)?(lib32-)?(opencl-)?nvidia-[0-9]+xx)' | awk '{print $1}'
    )

    if [[ ${#INSTALLED_NVIDIA_PKGS[@]} -eq 0 ]]; then
        echo -e "ℹ️  ${YELLOW}No se encontraron paquetes NVIDIA instalados.${NC}\n"
        return
    fi

    echo -e "🧾 ${GREEN}Paquetes detectados:${NC}\n"
    for pkg in "${INSTALLED_NVIDIA_PKGS[@]}"; do
        echo -e "  - $pkg"
    done

    read -p $'\n¿Deseas iniciar la desinstalación de estos paquetes? [s/N]: ' confirm
    if ! [[ "$confirm" =~ ^[sS]$ ]]; then
        echo -e "\n❌ Operación cancelada por el usuario.\n"
        return
    fi

    for pkg in "${INSTALLED_NVIDIA_PKGS[@]}"; do
        echo -e "\n📦 Paquete: ${YELLOW}$pkg${NC}"
        read -p "¿Desinstalación limpia (con dependencias)? [s/N]: " confirmClean
        if [[ "$confirmClean" =~ ^[sS]$ ]]; then
            sudo pacman -Rsc --noconfirm "$pkg"
        else
            sudo pacman -Rdd --noconfirm "$pkg"
        fi
        echo -e "${GREEN}✔️  Eliminado: $pkg${NC}"
    done

    echo -e "\n✅ ${GREEN}Desinstalación de drivers NVIDIA finalizada.${NC}\n"
}


# === EJECUCIÓN ===
# =================

verificar_argumento
listar_drivers_instalados
comparar_version
confirmar_reemplazo
instalar_paquetes


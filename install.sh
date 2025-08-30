#!/usr/bin/env bash

# INSTALL SCRIPT

## VARS - CONST DEFINITIONS
oscfg_debug_log_dir="/tmp/oscfg/log/"

splash_screen='
          ▒█████    ██████  ▄████▄    █████▒ ▄████
         ▒██▒  ██▒▒██    ▒ ▒██▀ ▀█  ▓██   ▒ ██▒ ▀█▒
         ▒██░  ██▒░ ▓██▄   ▒▓█    ▄ ▒████ ░▒██░▄▄▄░
         ▒██   ██░  ▒   ██▒▒▓▓▄ ▄██▒░▓█▒  ░░▓█  ██▓
         ░ ████▓▒░▒██████▒▒▒ ▓███▀ ░░▒█░   ░▒▓███▀▒
         ░ ▒░▒░▒░ ▒ ▒▓▒ ▒ ░░ ░▒ ▒  ░ ▒ ░    ░▒   ▒
           ░ ▒ ▒░ ░ ░▒  ░ ░  ░  ▒    ░       ░   ░
         ░ ░ ░ ▒  ░  ░  ░  ░         ░ ░   ░ ░   ░
             ░ ░        ░  ░ ░                   ░
                           ░
 ██▓ ███▄    █ ▄▄▄█████▓ ▄▄▄       ██▓     ██▓    ▓█████  ██▀███
▓██▒ ██ ▀█   █ ▓  ██▒ ▓▒▒████▄    ▓██▒    ▓██▒    ▓█   ▀ ▓██ ▒ ██▒
▒██▒▓██  ▀█ ██▒▒ ▓██░ ▒░▒██  ▀█▄  ▒██░    ▒██░    ▒███   ▓██ ░▄█ ▒
░██░▓██▒  ▐▌██▒░ ▓██▓ ░ ░██▄▄▄▄██ ▒██░    ▒██░    ▒▓█  ▄ ▒██▀▀█▄
░██░▒██░   ▓██░  ▒██▒ ░  ▓█   ▓██▒░██████▒░██████▒░▒████▒░██▓ ▒██▒
░▓  ░ ▒░   ▒ ▒   ▒ ░░    ▒▒   ▓▒█░░ ▒░▓  ░░ ▒░▓  ░░░ ▒░ ░░ ▒▓ ░▒▓░
 ▒ ░░ ░░   ░ ▒░    ░      ▒   ▒▒ ░░ ░ ▒  ░░ ░ ▒  ░ ░ ░  ░  ░▒ ░ ▒░
 ▒ ░   ░   ░ ░   ░        ░   ▒     ░ ░     ░ ░      ░     ░░   ░
 ░           ░                ░  ░    ░  ░    ░  ░   ░  ░   ░

';


defult_cfg_dir="$HOME/.conf"

ORIGINAL_USER=$SUDO_USER

# Si la variable $SUDO_USER no está definida (ej. se ejecutó directamente con sudo),
# asignamos el usuario actual
if [[ -z "$ORIGINAL_USER" ]]; then
    ORIGINAL_USER=$(whoami)
fi

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

## UTIL FUNCTIONS

splash_screen() {
    echo "$splash_screen";
}

splash_and_clear() {
    splash_screen;
    sleep 2;
    clear;
}

pause() {
  read -p "Continue..."
}

alert() {
        local RED='\033[0;31m'
        local GREEN='\033[0;32m'
        local YELLOW='\033[0;33m'
        local CYAN='\033[0;36m'
        local NO_COLOR='\033[0m' # Código para resetear el color
        local type="$1"
        local message="$2"

    case "$type" in
        info)
            echo -e "${CYAN}[INFO]${NO_COLOR} $message"
            ;;
        success)
            echo -e "${GREEN}[SUCCESS]${NO_COLOR} $message"
            ;;
        warning)
            echo -e "${YELLOW}[WARNING]${NO_COLOR} $message"
            ;;
        error)
            echo -e "${RED}[ERROR]${NO_COLOR} $message"
            ;;
        *)
            # Tipo de alerta por defecto si no coincide con ninguno de los anteriores
            echo "[MESSAGE] $message"
            ;;
    esac
}

clear_confirm() {
    pause;
    clear;
}

countdown() {
  for ((i=3; i>0; i--)); do
    echo -n "$i... "
    sleep 1
  done
  echo "¡GO!"
}


## Util system functions

dir_exits() {
    # The -d test returns true if the path is a directory and it exists.
    if [ -d "$1" ]; then
        return 0  # Return 0 for success (the directory exists).
    else
        return 1  # Return 1 for failure (it doesn't exist or is not a directory).
    fi
}

safe_mkdir() {
    # Comprobamos si el primer argumento está vacío.
    if [ -z "$1" ]; then
        alert error "A directory path is required." >&2
        return 1
    fi

    # Usamos mkdir -p para crear el directorio.
    mkdir -p "$1"

    # Verificamos el código de salida del comando `mkdir`.
    if [ $? -eq 0 ]; then
        alert info "Directory '$1' created or already exists on your system."
        return 0
    else
        alert error "Error: Could not create directory '$1'. Check permissions." >&2
        return 1
    fi
}

clean_path() {
    local path="$1"

    # Elimina la barra final si no es solo la raíz.
    if [[ "$path" =~ ^(.+)/$ ]] && [[ "$path" != "/" ]]; then
        path="${BASH_REMATCH[1]}"
    fi

    echo "$path"
}

require_root() {
    if [[ $EUID -ne 0 ]]; then
        echo "This script requires superuser privileges." >&2
        sudo "$0"
        exit
    fi
}

check_write_permissions() {
    local folder_path="$1"

    # La prueba -w verifica si un archivo o directorio es escribible.
    if [[ -w "$folder_path" ]]; then
        return 0
    else
        alert error "Permission denied. Cannot write in '$folder_path'." >&2
        return 1
    fi
}

create_symlink() {
    local source_path="$1"
    local link_path="$2"

    # Argument validation
    if [[ -z "$source_path" || -z "$link_path" ]]; then
        echo "Error: Two arguments (source and link destination) are required." >&2
        return 1
    fi

    # 1. Check if the source exists.
    if [[ ! -e "$source_path" ]]; then
        echo "Error: The source file or directory '$source_path' does not exist." >&2
        return 1
    fi

    # 2. Check if the link destination already exists as a symbolic link.
    if [[ -L "$link_path" ]]; then
        echo "The symbolic link at '$link_path' already exists."
        return 0
    fi

    # 3. Attempt to create the symbolic link.
    if ln -s "$source_path" "$link_path"; then
        echo "Symbolic link created successfully: '$link_path' -> '$source_path'"
        return 0
    else
        echo "Error: Failed to create the symbolic link at '$link_path'." >&2
        return 1
    fi
}

## Installer functions

CONFIG_DIR=""
INSTALLATION_DIR=""
try_use_custom_cfg_dir(){
    local custom_var="OSCFG_CONFIG_DIR"
    if [ -v $custom_var ]; then
        local aux="${!custom_var}";
        CONFIG_DIR="$(clean_path $aux)"
        return 0;
    fi
    return 1;
}

try_use_custom_install_dir(){
    local custom_var="OSCFG_INSTALL_DIR"
    if [ -v $custom_var ]; then
        local aux="${!custom_var}";
        INSTALLATION_DIR="$(clean_path $aux)"
        return 0;
    fi
    return 1;
}

user_chown() {
    local new_owner_usr="$1"
    local target_file="$2"
    chown "$new_owner_usr":"$new_owner_usr" "$2"
}

install_oscfg() {
    try_use_custom_install_dir;
    local oscfg_tool_dir="${INSTALLATION_DIR:-/opt/}"
    oscfg_tool_dir="$(clean_path $oscfg_tool_dir)"
    alert info "Trying copy tool in $oscfg_tool_dir/oscfg"
    if check_write_permissions "$oscfg_tool_dir"; then
        alert info "Copying tool in $oscfg_tool_dir/oscfg"
    else
        alert Error "Copying tool in $oscfg_tool_dir/oscfg"
        require_root;
    fi
    echo "CP $SCRIPT_DIR to $oscfg_tool_dir"
    cp -rv "$SCRIPT_DIR" "$oscfg_tool_dir" >/tmp/oscfg/log/oscfg_installer_copy.log
    alert info "You can check which files was copied in: /tmp/oscfg/log/oscfg_installer_copy.log"
    ##require_root;
    create_symlink "$oscfg_tool_dir/oscfg/cli/oscfg-cli" "/usr/bin/"

}

startup_routine() {
    splash_and_clear;
    echo "Starting OSCFG installation script..."
    countdown;
    clear;
}

create_usr_cfg_dir() {
    try_use_custom_cfg_dir
    local config_dir="${CONFIG_DIR:-$defult_cfg_dir}"
    alert info "Doing installation for the user $ORIGINAL_USER"
    alert info "using this config directory: $config_dir"
    safe_mkdir "$config_dir/oscfg";
}

## Script routine

mkdir -p "$oscfg_debug_log_dir"

startup_routine;
create_usr_cfg_dir;
install_oscfg;

#!/usr/bin/env bash

# --- 8 standard colors ---
BLACK="\033[0;30m"
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
MAGENTA="\033[0;35m"
CYAN="\033[0;36m"
WHITE="\033[0;37m"

# --- Bright versions ---
BRIGHT_BLACK="\033[1;30m"
BRIGHT_RED="\033[1;31m"
BRIGHT_GREEN="\033[1;32m"
BRIGHT_YELLOW="\033[1;33m"
BRIGHT_BLUE="\033[1;34m"
BRIGHT_MAGENTA="\033[1;35m"
BRIGHT_CYAN="\033[1;36m"
BRIGHT_WHITE="\033[1;37m"

# --- Background colors ---
BG_BLACK="\033[40m"
BG_RED="\033[41m"
BG_GREEN="\033[42m"
BG_YELLOW="\033[43m"
BG_BLUE="\033[44m"
BG_MAGENTA="\033[45m"
BG_CYAN="\033[46m"
BG_WHITE="\033[47m"

# --- Bright background colors ---
BG_BRIGHT_BLACK="\033[100m"
BG_BRIGHT_RED="\033[101m"
BG_BRIGHT_GREEN="\033[102m"
BG_BRIGHT_YELLOW="\033[103m"
BG_BRIGHT_BLUE="\033[104m"
BG_BRIGHT_MAGENTA="\033[105m"
BG_BRIGHT_CYAN="\033[106m"
BG_BRIGHT_WHITE="\033[107m"



NO_COLOR='\033[0m' # Código para resetear el color
RESET='\033[0m' # Código para resetear el color

alert() {
       
        local type="$1"
        local message="$2"
    
    case "$type" in
        info)
            echo -e "${BRIGHT_CYAN}[INFO]${NO_COLOR} $message"
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
        debug)
            echo -e "${BG_YELLOW}[debug]${NO_COLOR} $message"
            ;;
        *)
            # Tipo de alerta por defecto si no coincide con ninguno de los anteriores
            echo -e "[MESSAGE] $message"
            ;;
    esac
}

countdown() {
  for ((i=3; i>0; i--)); do
    echo -n "$i... "
    sleep 1
  done
  echo "¡GO!"
}

pause() {
  read -p "Continue..."
}

confirm() {
    read -p "Do you want to continue? [Y/n]: " answer
    answer=${answer:-Y}

    if [[ "$answer" =~ ^[Yy]$ ]]; then
        echo "Continuing..."
        return 0
    else
        echo "Operation canceled."
        return 1
    fi
}

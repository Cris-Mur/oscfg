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


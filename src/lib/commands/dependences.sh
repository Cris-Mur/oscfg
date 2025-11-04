#!/usr/bin/env bash


chck_dependences () {
    local dependences="less bat tree realpath";
    alert info "evaluating this dependences:${BRIGHT_MAGENTA} $dependences${RESET}"
    chck_programs $dependences;
}

chck_programs () {
    local missing_programs=()
    local program

    for program in "$@"; do
        if ! command -v "$program" &> /dev/null; then
            missing_programs+=("$program")
        fi
    done

    if [ ${#missing_programs[@]} -eq 0 ]; then
        alert success "✅ Todos los programas requeridos están instalados y en el PATH."
        return 0 # Éxito
    else
        alert error "❌ Faltan uno o más programas requeridos:"
        for missing in "${missing_programs[@]}"; do
            echo " - $missing"
        done
        alert info "Por favor, instálalos e inténtalo de nuevo."
        return 1 # Fallo
    fi
}




#!/usr/bin/env bash

is_symlink_to() {
    local link="$1"
    local target="$2"

    # Deben existir ambos argumentos
    [[ -z "$link" || -z "$target" ]] && {
        echo "Uso: is_symlink_to <enlace> <objetivo>" >&2
        return 2
    }

    # Si el link no es un enlace simbólico, devuelve falso
    [[ ! -L "$link" ]] && return 1

    # Obtener el path real al que apunta el enlace
    local resolved
    resolved="$(readlink -f -- "$link" 2>/dev/null)" || return 1

    # Resolver también el target a su ruta absoluta real
    local real_target
    real_target="$(readlink -f -- "$target" 2>/dev/null)" || return 1

    # Comparar
    [[ "$resolved" == "$real_target" ]]
}

check_symlink() {
    if is_symlink_to "$1" "$2"; then
        echo "✅ '$1' es un symlink que apunta a '$2'"
    else
        echo "❌ '$1' NO apunta a '$2'"
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
        echo "[WARNING]: The symbolic link at '$link_path' already exists."
        return 1
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


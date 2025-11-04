#!/usr/bin/env bash

list_only_dotfiles () {
    local dir="${1:-$HOME}"  # por defecto, $HOME
    shopt -s dotglob nullglob
    local files=("$dir"/.*)
    shopt -u dotglob

    # Filtra los especiales "." y ".."
    for f in "${files[@]}"; do
        [[ "$(basename "$f")" =~ ^\.\.?$ ]] && continue
        [[ -f "$f" ]] && echo "$f"
    done
}

list_dir () {
    local dir="${1:-.}"  # usa el directorio actual si no se pasa argumento
    local entry

    # Si no existe o no es un directorio → error
    [[ ! -d "$dir" ]] && {
        echo "Error: '$dir' no es un directorio" >&2
        return 1
    }

    # Iterar sobre todo lo que esté en el primer nivel
    shopt -s nullglob dotglob
    for entry in "$dir"/* ; do
        # excluir . y ..
        [[ "$(basename "$entry")" =~ ^\.\.?$ ]] && continue
        echo "$entry"
    done
    shopt -u nullglob dotglob
}

#!/usr/bin/env bash

install_dotFiles_folder() {
    if [ ! -e "$1" ]; then
        echo -e "${YELLOW}WARNING:${NO_COLOR} dotFile's Folder NOT Found at path $1"
        return 1;
    fi
    DOTFILE_FOLDER_PATH=$1;

    find -L "$DOTFILE_FOLDER_PATH" -type f | while IFS= read -r dotfile; do
        echo -e "FOUND file name: $dotfile";
        fileName=$(basename $dotfile);
        folderName=$(dirname $dotfile);
        typeOfDotfile=$(basename $folderName);
        echo -e "${YELLOW}[ INSTALLING ]${NO_COLOR} $typeOfDotfile FILE: ${CYAN}$fileName${NO_COLOR}"
        create_symlink $dotfile "$HOME/$fileName";
        if [[ $? -eq 1 ]]; then
            echo -e "${RED}[ERROR]${NO_COLOR}";
            continue;
        fi
        if [[ -e "$HOME/$fileName" ]]; then
           echo -e "${GREEN}[ # SUCCESS # ]${NO_COLOR} dotfile was installed 🥳✅"
        fi
    done

    return 0;
}

get_enable_modules () {
    for module in $(list_dir $ENABLED); do
        echo -e $(basename $module);
    done
}



check_dotfiles_links() {
    local dotdir="${1:-$HOME/.config/user_dotfiles}"  # Directorio donde están los dotfiles
    local file name homelink

    [[ ! -d "$dotdir" ]] && {
        echo "Error: '$dotdir' no es un directorio válido." >&2
        return 1
    }

    # Activamos dotglob para incluir archivos ocultos
    shopt -s dotglob nullglob
    for file in "$dotdir"/*; do
        [[ "$(basename "$file")" =~ ^\.\.?$ ]] && continue  # saltar . y ..

        name="$(basename "$file")"
        homelink="$HOME/$name"

        # Caso 1: no existe en $HOME
        if [[ ! -e "$homelink" ]]; then
            echo "❌ $name → no existe en \$HOME"
            continue
        fi

        # Caso 2: existe pero no es enlace
        if [[ ! -L "$homelink" ]]; then
            echo "⚠️  $name → existe pero no es un symlink"
            continue
        fi

        # Caso 3: es symlink, comprobamos destino real
        local target
        target="$(readlink -f -- "$homelink" 2>/dev/null)"
        local real
        real="$(readlink -f -- "$file" 2>/dev/null)"

        if [[ "$target" == "$real" ]]; then
            echo "✅ $name → correctamente vinculado"
        else
            echo "🔁 $name → symlink roto o apunta a otro destino"
        fi
    done
    shopt -u dotglob nullglob
}

#!/usr/bin/env bash


list_modules() {
    alert info "USING DOTFILE DIRECTORY:\n\t$CONFIG_DIR"
    echo -e "\n${CYAN}-------------------------------"
    echo -e "##  Available config modules:"
    echo -e "-------------------------------${NO_COLOR}\n"
    for f in "$AVAILABLE"/*; do
        name=$(basename "$f")
        if [ -L "$ENABLED/$name" ]; then
            echo -e "${BRIGHT_GREEN}  [✔] $name${NO_COLOR}"
        else
            echo -e "  [ ] $name"
        fi
        get_safe_dir_tree $f | sed 's/^/      /'
    done
    echo -e "\n-------------------------------\n"
    alert info "Enable modules are stored on:${NO_COLOR}"
    echo -e "\n\t${BLACK}${BG_BRIGHT_GREEN}$ENABLED${NO_COLOR}"
}



#!/usr/bin/env bash

module_status () {
    alert info "HOME Dotfiles:"
    for module in $(get_enable_modules); do
        module_name=$(basename "$ENABLED/$module");
        alert info "[ $module_name ]"
        check_dotfiles_links "$ENABLED/$module";
    done
}


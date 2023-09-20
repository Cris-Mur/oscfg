#!/usr/bin/env bash
# Installatopn script to install YAY
#
if [ ! -d "$HOME/AUR" ]; then
    echo "Aur Dir doesnt exist."
    mkdir -p "$HOME/AUR"
fi
cd "$HOME/AUR"
if [ ! -d "$HOME/AUR/yay" ]; then
    git clone https://aur.archlinux.org/yay.git
fi
cd yay
makepkg -si

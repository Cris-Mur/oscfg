#!/usr/bin/env bash

src_file="$HOME/oscfg/dotfiles/editors/vim/vanilla/.vimrc"

if [ -f "$src_file" ]; then
    ln -s "$src_file" "$HOME/$src_file"
else
    echo "not found souce properly: $src_file"
fi
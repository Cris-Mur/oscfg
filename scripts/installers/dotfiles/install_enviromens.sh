#!/usr/bin/env bash

src_dir="$HOME/oscfg/dotfiles/env"

if [ -d "$src_dir" ]; then
    ln -s "$src_dir" "$HOME/env"
else
    echo "not found souce dir properly: $src_dir"
fi
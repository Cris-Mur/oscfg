#!/usr/bin/env bash

src_dir="$HOME/oscfg/dotfiles/bash"

if [ -d "$src_dir" ]; then
    files=$(find "$src_dir" -maxdepth 1 -type f -exec basename {} \;)
    for file in $files; do
        filename=$(basename "$file")  # Extract the file name
        echo
        echo "installing bash file: $filename to $HOME/$filename"
        original_path=$(readlink -f "$HOME/$filename")
        path_length=${#original_path}

        if [ "$path_length" -gt 2 ] && [ "$original_path" != "$HOME/$filename" ]; then
        echo "[ original path ] $original_path"
            echo "Symbolic link already exists."
            continue
        else
            rm -rf "$HOME/$filename"
        fi
        ln -s "$src_dir/$filename" "$HOME/$filename"
    done
else
    echo "Source directory not found: $src_dir"
    echo "Please input source folder: (only name path without '/' character)"
    read -p "Folder > " input_dir
    files=$(find "$input_dir" -maxdepth 1 -type f -exec basename {} \;)
    for file in $files; do
        echo "installing bash file: $filename to $HOME/$filename"
        ln -s "$input_dir/$file" "$HOME/$file"
    done
fi

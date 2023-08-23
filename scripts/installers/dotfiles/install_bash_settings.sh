#!/usr/bin/env bash

src_dir="$HOME/oscfg/dotfiles/bash"

if [ -d "$src_dir" ]; then
    files=$(find "$src_dir" -maxdepth 1 -type f -exec basename {} \;)
    for file in $files; do
        filename=$(basename "$file")  # Extract the file name
        echo "installing bash file: $filename"
        ln -s "$file" "$HOME/$filename"
    done
else
    echo "not found souce dir properly: $src_dir"
    echo "Pleace input source folder: (only name path without '/' character)\n"
    read -p "Folder > " input_dir
    files=$(find "$input_dir" -maxdepth 1 -type f -exec basename {} \;)
    for file in $files;
    do
        echo "installing bash file: $file"
        ln -s $input_dir/$file ~/$file
    done
fi
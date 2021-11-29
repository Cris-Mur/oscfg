#!/usr/bin/env bash

echo "### [ Installing Vim Plug ]\n"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "[## DONE ##]\n"

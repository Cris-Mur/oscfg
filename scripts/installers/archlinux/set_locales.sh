#!/usr/bin/env bash

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi

main_LANG="es_CO.UTF-8";

another_langs='
en_US.UTF-8
ja_JP.UTF-8
';

enable-locale "$main_LANG" $another_langs
locale-gen

locale_file="/etc/locale.conf";

if [ ! -f "$locale_file" ]; then
    echo "Creating $locale_file file."
else
    echo "Over Writing file..."
fi

echo -e "LANG=$main_LANG" > $locale_file
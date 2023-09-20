#!/usr/bin/env bash
# Installation of Graphic server and default intel Graphics Driver

if [ "$(id -u)" -ne 0 ]; then
    if [ -x /usr/bin/yay ]; then
        yay -S nvidia-390xx-dkms nvidia-390xx-utils lib32-nvidia-390xx-utils optimus-manager
    else
        echo -e "you dont have a yay installation and youre not root."
        exit 1;
    fi
    exit;
else
    pacman -S xorg mesa xf86-video-intel lib32-mesa xf86-input-libinput
fi


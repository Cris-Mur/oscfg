#!/usr/bin/env bash
# Grub 2 Installation Script for EFI System

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi

if [ -x /usr/bin/grub-install ]; then
    grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
    grub-mkconfig -o /boot/grub/grub.cfg
fi

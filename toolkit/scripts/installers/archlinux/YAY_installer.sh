#!/usr/bin/bash

echo ""
echo "Clonning YAY AUR Repository..."

git clone https://aur.archlinux.org/yay.git /opt/

echo "Yet Another Yogurt are cloned into /opt"

cd /opt/yay/
echo ""
pwd
echo ""

makepkg -si


#!/usr/bin/env bash
pacman -S sddm sddm-kcm plasma yakuake dolphin kate
systemctl enable sddm.service

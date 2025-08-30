#!/usr/bin/env bash

pacman -S bluez bluez-utils bluedevil pulseaudio-bluetooth
systemctl enable bluetooth.service
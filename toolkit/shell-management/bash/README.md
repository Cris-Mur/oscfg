# BASH Config Manager

This folder contains the source code of a helper script to manage your bash installation

# Features

## Nice UI

The idea of this helper it was to have a nice ui/ux inside the terminal, have usefull tool, and improve initial setup of bash shell.

- proposal setup

This helper build a opinionated setup for bash settings, and try to be the most close to unix-like setup for the dotfiles.
This is part of a bigger helper tool called oscfg, that propouse this setup structure.

- config as a feature

I like it a configurable environment, for this I build the settings like a modular kit.

- versionable result setup

The resulting setup is stored into a user default config folder `.config` into `oscfg` folder, which is compatible with a source version solution like `git` 

---

## Overview

This tool, follow default bash setup and over these build a own setup.

The default shell setup is in `/etc` folder, and in order the Main System Shell, loads or run this files depends of your user default shell.

for bash, the configuration string is:

- `/etc/profile`
- `~/.bash_profile`

Normally you modify a user's bash profile to load a `.bashrc` file.

---

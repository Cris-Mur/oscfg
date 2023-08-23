#
# ~/.bashrc
#[ @Cris-Mur ]
#
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -f ~/.bash_cfg_profile ]; then
    . ~/.bash_cfg_profile
fi


if [ -f ~/.bash_cfg_history ]; then
    . ~/.bash_cfg_history
fi

if [ -f ~/.bash_cfg_prompt ]; then
  . ~/.bash_cfg_prompt
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# Bash Completion settings
if [ -f ~/.bash_cfg_completion ]; then
  . ~/.bash_cfg_completion
fi

# load enviroment variables dir
if [ -d ~/env/ ]; then
  for env_file in ~/env/*
  do
    echo "load $env_file"
    . $env_file
  done
fi
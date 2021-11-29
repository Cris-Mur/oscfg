#
# ~/.bashrc
#[ @Cris-Mur ]
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=always'
alias l='ls -lh'
alias ll='ls -lah'
PS1='[\u@\h \W]\$ '

alias emacs='emacs -nw'
alias tom='~/settings_linux/./git_log.sh'
alias gcc='gcc -Wall -pedantic -Werror -Wextra'
alias js-bang='echo "#!/usr/bin/node" | tee *.js'
alias bsh-bang='echo "#!/usr/bin/bash" | tee *.sh'
alias py-bang='echo "#!/usr/bin/python3" | tee *.py'
alias envy-bsh='echo "#!/usr/bin/env bash" | tee *.sh'
alias sts='git status'
alias daily='cat $HOME/daily'
alias t='tree -aI "node_modules|.git"'
alias mv='mv -iv'
alias cp='cp -riv'
alias mkdir='mkdir -pv'

PS1='[ \e[91m\]\d\[\e[00m\] \[\e[33m\]\t\[\e[m\] ]\[ \[\e[01;35m\]\u\[\e[00m\]@\[\e[01;32m\]\h\[\e[00m\] \[\e[01;34m\]\W\[\e[00m\] ] \[$(ls -A| wc -l)\] \$ '

PATH="$PATH:~/.emacs.d/bin"

alias dnc='dotnet new console -o'
alias br='dotnet build && dotnet run'

DEVKITPRO=/opt/devkitpro
DEVKITARM=/opt/devkitpro/devkitARM
DEVKITPPC=/opt/devkitpro/devkitPPC

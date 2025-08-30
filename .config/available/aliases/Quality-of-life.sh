#################################################################
##### Quality of life Bash Aliases ##############################
#################################################################

# Navegación rápida
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd ~"
alias cdd="cd ~/Documentos"
alias cdp="cd ~/Proyectos"

# Listados mejorados
alias ls="ls --color=auto"
alias ll="ls -lh"
alias la="ls -A"
alias lla="ls -lha"
alias lt="ls -ltr"   # orden por fecha

# Buscar en archivos y procesos
alias grep="grep --color=auto"
alias psg="ps aux | grep -i"   # ejemplo: psg nginx
alias f="find . -name"

# Atajos comunes
alias cls="clear"
alias h="history"
alias j="jobs -l"

# Edición rápida de configuración
alias bashrc="vi ~/.bashrc && source ~/.bashrc"
alias aliases="vi ~/.bash_aliases && source ~/.bashrc"

# Git (si usas git mucho)
alias gs="git status"
alias ga="git add ."
alias gc="git commit -m"
alias gp="git push"
alias gl="git log --oneline --graph --decorate --all"

# Seguridad / prevención
alias rm="rm -i"   # pide confirmación antes de borrar
alias cp="cp -i"
alias mv="mv -i"

# Red y sistema
alias myip="curl ifconfig.me"
alias ports="netstat -tulnp"
alias df="df -h"
alias du="du -sh *"

# Misceláneos
alias update="sudo apt update && sudo apt upgrade -y"
alias please="sudo !!"   # repite el último comando con sudo
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


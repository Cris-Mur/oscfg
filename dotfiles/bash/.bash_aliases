############################## ALIASES | CRIS-MUR #############################

## Git
alias sts='git status'

## Dotnet
if [ -x /usr/bin/dotnet ]; then
    alias dnc='dotnet new console -o'
    alias br='dotnet build && dotnet run'
fi

## GCC
if [ -x /usr/bin/gcc ]; then
    alias gcc='gcc -Wall -pedantic -Werror -Wextra'
fi
## OS

alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -lh'

if [ -x /usr/bin/tree ]; then
    alias t='tree -aI "node_modules|.git"'
    alias td='t -d'
fi

alias mv='mv -iv'

alias cp='cp -riv'

alias mkdir='mkdir -pv'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Utils
alias js-bang='echo "#!/usr/bin/node" | tee *.js'
alias bsh-bang='echo "#!/usr/bin/bash" | tee *.sh'
alias py-bang='echo "#!/usr/bin/python3" | tee *.py'
alias envy-bsh='echo "#!/usr/bin/env bash" | tee *.sh'

## Editors

### Emacs

if [ -x /usr/bin/emacs ]; then
	alias emacs='emacs -nw'
fi
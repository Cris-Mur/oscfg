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

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -lh'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


############################## ALIASES | CRIS-MUR #############################

alias emacs='emacs -nw'
alias glog='~/settings_linux/scripts/./git_log.sh'
alias gcc='gcc -Wall -pedantic -Werror -Wextra'
alias js-bang='echo "#!/usr/bin/node" | tee *.js'
alias bsh-bang='echo "#!/usr/bin/bash" | tee *.sh'
alias py-bang='echo "#!/usr/bin/python3" | tee *.py'
alias envy-bsh='echo "#!/usr/bin/env bash" | tee *.sh'
alias sts='git status'
alias daily='cat $HOME/daily'
alias t='tree -aI "node_modules|.git"'
alias td='t -d'
alias mv='mv -iv'
alias cp='cp -riv'
alias mkdir='mkdir -pv'
alias dnc='dotnet new console -o'
alias br='dotnet build && dotnet run'

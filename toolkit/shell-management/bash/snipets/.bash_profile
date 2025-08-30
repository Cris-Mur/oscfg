#
# ~/.bash_profile
#
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi # check and run rc file

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize;

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


### display system info
if command -v fastfetch >/dev/null 2>&1; then
	fastfetch;
else if command -v neofetch >/dev/null 2>&1; then
	neofetch;
fi

### Environment
$ env_folder="$XDG_CONFIG_HOME/oscfg/env/"
# load enviroment variables dir
#
load_env_files () {
	if [ -d $env_folder ]; then
        	env_counter=0;
        	for env_file in $env_folder*
        	do
        	. $env_file
                	let env_counter++;
        	done
        	echo "$env_counter# Enviroment files are loaded."
	fi
}


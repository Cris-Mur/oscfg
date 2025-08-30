#!/usr/bin/env bash


## TODO
#
# 0.1 		acces to space (config folder of bash)
# 0.2 		build a .bashrc
# 0.2.1 	copy a minimal example.
# 0.2.2		setup behaviour
# 0.2.2.1	history
# 0.2.2.2	login - logout
# 0.2.2.3	integrations with apps
# 0.2.2.3.1	select and install
# 0.2.2.3.2	copy integrations
# 0.2.3		setup environments
# 0.2.3.1	acces to env space
# 0.2.3.2	confirm & copy env files
# 0.2.4		setup aliases
# 0.2.4.1	select and install
#

homeDIR="~/"

if [ "$(id -u)" -eq 0 ]; then
    echo "Script running as root"

fi


startup_message='
__________               .__        _________       __                
\______   \_____    _____|  |__    /   _____/ _____/  |_ __ ________  
 |    |  _/\__  \  /  ___/  |  \   \_____  \_/ __ \   __\  |  \____ \ 
 |    |   \ / __ \_\___ \|   Y  \  /        \  ___/|  | |  |  /  |_> >
 |______  /(____  /____  >___|  / /_______  /\___  >__| |____/|   __/ 
        \/      \/     \/     \/          \/     \/           |__|    

This is a assistant to install bash settings.		
'
echo "$startup_message";


config_folder="$HOME/.config/oscfg/.dotfiles/bash"
# Access to bash config space
#
init_process () {
	if [ -d "$config_folder" ]; then
    		cd $config_folder;
    		echo "Jupped to user config folder $PWD"
	else
    		echo "Folder not found, creating folder"
    		mkdir -p "$config_folder"
		init_process;
	fi
}

init_process;

# minimal bash configuration
#
minimal_setup() {
	src="/opt/oscfg/Terminal_Settings/bash/bashrc"
	target="$config_folder"

	if [ -f "$src" ]; then
    		ln -s "$src" "$target/.bashrc"
    		echo "Added minimal bashrc: $target → $src"
	else
    		cp /etc/bash.bashrc "$target/.bashrc"
    		echo "Archivo copiado a $target"
	fi
}

confirm() {
    read -p "Do you want to continue? [Y/n]: " answer
    answer=${answer:-Y}

    if [[ "$answer" =~ ^[Yy]$ ]]; then
        echo "Continuing..."
        return 0
    else
        echo "Operation canceled."
        return 1
    fi
}

configure_history() {
    local config=""
    local extra=""

    read -p "Set HISTSIZE (number of commands to keep in memory): " histsize
    read -p "Set HISTFILESIZE (number of commands to keep in history file): " histfilesize
    read -p "Set HISTCONTROL (e.g. ignoredups, ignorespace, ignoreboth): " histcontrol
    read -p "Set HISTTIMEFORMAT (e.g. '%F %T '): " histtimeformat

    [ -n "$histsize" ] && config+="HISTSIZE=${histsize}\n"
    [ -n "$histfilesize" ] && config+="HISTFILESIZE=${histfilesize}\n"
    [ -n "$histcontrol" ] && config+="HISTCONTROL=${histcontrol}\n"
    [ -n "$histtimeformat" ] && config+="HISTTIMEFORMAT=\"${histtimeformat}\"\n"

    # Example of always-appended extra settings
    extra+="shopt -s histappend\n"
    extra+="PROMPT_COMMAND='history -a'\n"

    final_config="${config}${extra}"

    echo -e "$final_config" > "$target"
    echo "History configuration written to $target"
}

configure_login_logout_scripts() {
    read -p "Do you want to enable login/logout scripts? [Y/n]: " answer
    answer=${answer:-Y}

    if [[ "$answer" =~ ^[Yy]$ ]]; then
        echo "Enabling login/logout scripts..."
        # Example placeholders for login/logout scripts
        echo -e "# ~/.bash_login script\n# Commands executed at login" > "$HOME/.bash_login"
        echo -e "# ~/.bash_logout script\n# Commands executed at logout" > "$HOME/.bash_logout"
        echo "Login script created at ~/.bash_login"
        echo "Logout script created at ~/.bash_logout"
        return 0
    else
        echo "Login/logout scripts not enabled."
        return 1
    fi
}

configure_integrations() {
    read -p "Do you want to enable integrations? [Y/n]: " answer
    answer=${answer:-Y}

    if [[ "$answer" =~ ^[Yy]$ ]]; then
        echo "Enabling integrations..."
        enable_integrations
        return 0
    else
        echo "Integrations not enabled."
        return 1
    fi
}

enable_integrations() {
    if [ -z "$target" ]; then
        echo "Error: variable 'target' is not set."
        return 1
    fi

    if [ -d "$target" ]; then
        echo "Target directory already exists: $target"
    else
        mkdir -p "$target"
        echo "Target directory created: $target"
    fi
}



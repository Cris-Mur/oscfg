#!/usr/bin/env bash
# Create Common user to GNU/Linux
# Tool to make interactive create user
# @Cris-Mur - Cristian Murcia

message="\n
################ Create  USER Tool ################\n
# 1. Input User Name\n
# 2. Input Default Shell\n
# 3. Set Basic user Groups\n
# 4. Create a Home Dir??\n
######################################################\n
"

function inputUserName() {
    read -p "UserName (archi): " i_name;
    if [ -z "${i_name}" ]; then
        i_name="archi"
    fi
    echo $i_name;
}

function inputShell() {
    read -p "Default Shell (/bin/bash): " i_shell;
    if [ -z "${i_shell}" ]; then
        i_shell="/bin/bash"
    fi
    echo $i_shell;
}

function inputGroups() {
    read -p "(wheel): " i_shell;
    if [ -z "${i_groups}" ]; then
        i_groups="wheel"
    fi
    echo $i_groups;
}
function main() {
    echo -e $message;
    username=$(inputUserName);
    usershell=$(inputShell);
    echo -e "input user Groups in one string split by comma eg 'ftp,audio'."
    usergroups=$(inputGroups);
    commande="useradd -s ${usershell} -G ${usergroups} ${username}"
    eval "$commande"
    echo $(getent passwd | grep $username)
    passwd $username
}

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi

main

#usrname='crismur'

#useradd -m -s /bin/bash -G ftp,games,http,sys,uucp,wheel,audio,disk,input,kvm,optical,scanner,storage,video,network $usrname
#passwd $usrname

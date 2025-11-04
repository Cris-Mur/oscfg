#!/usr/bin/env bash

# TODO
#
# Path_file
# validate

validate_path () {
    local path=$(resolve_path "$1")
    if [ -z "$path" ]; then
        printf 'Error: No se proporcionó un path.\n' >&2
        return 1
    fi
    if ! [ -e "$path" ]; then
        printf 'Error: El path "%s" no existe.\n' "$path" >&2
        return 1
    fi
    return 0
}

# resolve

is_path_in_parent() {
    local path_hijo="$1"
    local path_padre="$2"

    if [[ "$path_padre" != */ ]]; then
        path_padre="$path_padre/"
    fi

    if [[ "$path_hijo" = "$path_padre"* ]]; then
        return 0
    else
        return 1
    fi
}

resolve_path() {
    input_path="$1"
    expanded="${input_path/#~/$HOME}"
    result=$(readlink -v -e $expanded)
    echo -e $result
}


# listar

list_path () {
    list=$(find_path $1);
    echo -e "$list"
}

find_path () {
    i_path="$1"
    if [ -z $i_path ]; then
        alert error 'empty input.'
        return 1;
    fi
    find -L "$i_path" -print -type f -o -type d 

}

# explorar


explorer_fzf(){
  fzf --ansi \
      --layout=reverse \
      --preview-window=down,70%,border-top,wrap \
      --cycle \
      --info=inline \
      --info-command='
        usage="Use ESC to exit."
        echo $usage
    '\
      --preview='
        full={};
        [ -d {} ] && ls -F --color=always {} ||
        (file {} | grep -q text && bat --color=always {} || file {})
      ';
}

folder_explorer(){
echo "iwi";
}
# dotfolder
#

get_dotfolder() {
    echo $CUSTOM_DOTFOLDER;
}


# locate
#
relocate_dotfolder() {
    alert info "Tenga encuenta que esta accion re ubica su directorio."
    if -z "$1"; then
        return 1;
    fi
    local new_dotfolder=$(resolve_path "$1");
    local _old_dotfolder=$CUSTOM_DOTFOLDER;
    local folder_name=$(basename $_old_dotfolder);
    cp -riv $_old_dotfolder $new_dotfolder;
    set_dotfolder "$new_dotfolder/$folder_name";
    local CONFIG_FILE=$OSCFG_user_dotfile;
    local CONFIG_VAR="CUSTOM_DOTFOLDER";
    local NEW_VALUE="$new_dotfolder/$folder_name"
    local ESCAPED_NEW_VALUE=$(echo "$NEW_VALUE" | sed 's/[\/&]/\\&/g');
    sed -i.bak -E "s/^($CONFIG_VAR=).*$/\1\"$ESCAPED_NEW_VALUE\"/" "$CONFIG_FILE"
    grep "$VAR_NAME" "$CONFIG_FILE"
}

# backup
# <git>
# 
# bundle

bundle_cmd () {
    alert debug "command bundle: $*"
    case "$1" in
        new | n | -n | --new) bundle_new $2;;
        delete | del | --delete | --del) bundle_delete $2;;
        l | list | -l | --list) list "${@:2}" ;;
        enable | e | -e | --enable) enable_module "${@:2}" ;;
        disable | d | -d | --disable) disable_module "${@:2}" ;;
        edit | ee | -ee | --edit) edit_cmd "${@:2}" ;;
        -h | --help | h | help) usage ;;
        *) pause ;;
    esac
    exit;
}

# create

bundle_new () {
    alert info "Creating bundle folder";
    alert debug "bundle name: [ $1 ]";
    DOTFOLDER=$(get_dotfolder);
    if [ ! -e $DOTFOLDER ]; then
        alert error "custom folder doesn't exist?"
        exit;
    fi
    local dotfolder=$(readlink -f "$DOTFOLDER");

    new_bundle_dir="$DOTFOLDER/$1"
    if [ ! -e $new_bundle_dir ]; then

        mkdir -v "$DOTFOLDER/$1"

    fi    
}

# delete

bundle_delete () {
    alert warning "DELETING bundle folder";
    alert debug "bundle name: [ $1 ]";
    pause;
    local DOTFOLDER=$(get_dotfolder);
    if [ ! -e $DOTFOLDER ]; then
        alert error "custom folder doesn't exist?"
        exit;
    fi
    local dotfolder=$(readlink -f "$DOTFOLDER");

    new_bundle_dir="$DOTFOLDER/$1"
    if [ -e $new_bundle_dir ]; then
        rm -i -r -v "$DOTFOLDER/$1"
    fi    
}

# edit

edit_cmd () {
    alert debug "command edit: $*"
    case "$1" in
        -a | --add | a | add) add_dotfile "${@:2}" ;;
        -rm | --remove | rm | remove) remove_dotfile "${@:2}" ;;
        -h | --help | h | help) usage ;;
        *) pause ;;
    esac
    exit;
}

# add

add_dotfile () {
    echo -e "Add Dotfile : $*"
    local bundle_name="$1"
    # Path to copy
    if [ -z $2 ]; then
        alert error "Cannot get file path. Please use one."
        exit 1;
    fi

    local input_path=$(resolve_path "$2" 2>/dev/null);
    if [ -z "$input_path" ] ; then
        input_path=$(resolve_path "$HOME/$2");
    fi
    echo -e "INPUT PATH: $input_path"
 
    local dotfolder=$(get_dotfolder);
    local bundle_folder=$(resolve_path "$dotfolder/$bundle_name")
    local on_bundle_path="${input_path#$HOME/}"
    local container_dir=$(dirname $on_bundle_path)
    echo -e "$input_path,\n$bundle_folder\n$HOME\n$on_bundle_path\n$container_dir"
    mkdir -p "$bundle_folder/$container_dir"
    cp -riv $input_path "$bundle_folder/$container_dir";
    alert info "DONE"
}

# remove

remove_dotfile () {
    echo -e "remove  dotfile: $*"
    local bundle_name="$1"
    # Path to copy
    if [ -z $2 ]; then
        alert error "Cannot get file path. Please use one."
        exit 1;
    fi
    local dotfolder=$(get_dotfolder);
    local bundle_folder=$(resolve_path "$dotfolder/$bundle_name")

    local input_path=$(resolve_path "$2" 2>/dev/null);
    if [[ ! -z $input_path ]]; then
        alert debug "resoved input: $input_path"
        # is bundle path?
        if is_path_in_parent $input_path $bundle_folder ; then
            alert debug "# Path starting on $bundle_folder"
            local no_homepath="${input_path#$bundle_folder}";
        elif is_path_in_parent $input_path $HOME; then
            alert debug "* Path starting on $HOME"
            local no_homepath="${input_path#$HOME}"
        fi
    else
        local no_homepath="/$2"
    fi

    alert debug "PATH of dotfile in bundle: $bundle_folder$no_homepath"
    if [ ! -e "$bundle_folder$no_homepath" ]; then
        alert error "this path no exist into the bundle. $bundle_name"
        alert debug "bundle: $bundle_folder"
        alert debug "Input parameter: $2"
        exit 1;
    fi
    alert debug "Se evalua si la ruta proporcionada existe en el bundle"

    target_path="$bundle_folder$no_homepath"
    dir_target=$(dirname ${target_path#$bundle_folder})
    file_target=$(basename $target_path)
        # is home path?
    echo -e "target: $target_path\n # $dir_target"
    trash_folder="$dotfolder/.trash/$bundle_name"
    echo -e "trash: $trash_folder$dir_target\n"
    pause;
    if [ -d "$target_path" ]; then
        mkdir -p "$trash_folder$dir_target/$file_target"
        cp -riv "$target_path/." "$trash_folder$dir_target/$file_target";
    else
        cp -iv "$target_path" "$trash_folder$dir_target/";
    fi
    alert info "Sending to trash..."
    pause;
    rm -rfv "$target_path"
    alert info "DONE"

}

# enable

enable_module() {
    local module="$1"
    local profile_dir=$(get_profile_repo)
    local dotfolder=$(get_dotfolder);
    local AVAILABLE=$dotfolder;
    local ENABLED=$profile_dir;

    if [ -z "$1" ]; then
        alert info "Ingrese el nombre de un bundle valido."
        exit 1;
    fi
    if [ ! -d "$AVAILABLE/$module/" ]; then
        echo "❌ No existe módulo: $AVAILABLE/$module"
        exit 1
    fi
    if [ ! -e $ENABLED ]; then
        mkdir -p $ENABLED;
    fi
    ln -sf "$AVAILABLE/$module" "$ENABLED/$module"
    echo "✔ Activado: $module"
}

# disable

disable_module() {
    local module="$1"
    local profile_dir=$(get_profile_repo)
    local dotfolder=$(get_dotfolder);
    local AVAILABLE=$dotfolder;
    local ENABLED=$profile_dir;

    if [ -z "$1" ]; then
        alert error "Invalid name."
        exit 1;
    fi
    if [ ! -d "$AVAILABLE/$module/" ]; then
        alert error "❌ Module didn't exist: $AVAILABLE/$module"
        exit 1
    fi
    
    unlink "$ENABLED/$module"
    alert error " ❌ disabled: $module"
}

# list

list_all_bundles() {
    local profile_dir=$(get_profile_repo)
    local dotfolder=$(get_dotfolder);
    local AVAILABLE=$dotfolder;
    local ENABLED=$profile_dir;

    alert info "USING DOTFILE DIRECTORY:\n\t$(get_dotfolder)"
    echo -e "\n${CYAN}-------------------------------"
    echo -e "##  Available config bundles:"
    echo -e "-------------------------------${NO_COLOR}\n"
    for f in "$AVAILABLE"/*; do
        name=$(basename "$f")
        if [ -L "$ENABLED/$name" ]; then
            echo -e "${BRIGHT_GREEN}  [✔] $name${NO_COLOR}"
        else
            echo -e "  [ ] $name"
        fi
        get_safe_dir_tree $f | sed 's/^/      /'
    done
    echo -e "\n-------------------------------\n"
    alert info "Enable bundles are stored on:${NO_COLOR}"
    echo -e "\n\t${BLACK}${BG_BRIGHT_GREEN}$ENABLED${NO_COLOR}" 
}

list_a_bundle() {
    alert debug "Query bundle: [$1]"
    alert info "Launching file explorer"
    pause;

    CUSTOM_DOTFOLDER=$(resolve_path $CUSTOM_DOTFOLDER);
    if [ ! -e $CUSTOM_DOTFOLDER ]; then
        alert error "custom folder doesn't exist?"
        exit;
    fi
    local dotfolder=$(readlink -f "$CUSTOM_DOTFOLDER");
    alert debug "dotfolder: $dotfolder\n"
    if [ -e "$dotfolder/$1" ]; then
        #local file_content=$(fe "$dotfolder/$1");
        list_path "$dotfolder/$1" | explorer_fzf;
    fi
}

list() {
    alert debug "[command: $1][subcommand: $2]"
    case "$1" in
        all | a | -a | --all) list_all_bundles ;;
        -h | --help | h | help) usage ;;
        *) 
            if [ "$1" == "" ]; then
                list_all_bundles;
            else
                list_a_bundle "$1";
            fi
        ;;

    esac
}

#
# profile

get_profile_repo() {
    echo -e "$PROFILE_ENABLE_DIR";
}

# status
# intall
#
# 
# user
#

user () {
    alert debug "command user: $*"
    case "$1" in
        d | dotfolder) echo -e "${BRIGHT_RED}${@:2}${RESET}" ;;
        b | bundle) bundle_cmd "${@:2}";;
        -h | --help | h | help) usage ;;
        *) pause ;;
    esac
    user_info;
}

user_info () {
    alert debug "Getting user info"
    alert info "[ user name ]: $USER"
    alert info "[ user dotfolder ]: $CUSTOM_DOTFOLDER"
}

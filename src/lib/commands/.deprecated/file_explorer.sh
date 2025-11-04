#!/usr/bin/env bash

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

function fe {
    local file_or_dir

    local query_path=$1

    if ! validate_path "$query_path"; then
        return 1
    fi
    
    dir_arr_path=(find -L "$query_path" -print -type f -o -type d) 
    ## "${dir_arr_path[@]}" 
    file_or_dir=$(
        "${dir_arr_path[@]}" 2>/dev/null | tail -n +2 |
             sort -u |
            explorer_fzf 
    )

    echo $file_or_dir
    if [ -z "$file_or_dir" ]; then
        return 1
    elif [ -d "$file_or_dir" ]; then
        cd "$file_or_dir" || return
    #else
        #bat $file_or_dir 2>/dev/null || return
    fi
}

function feO {
    local file_or_dir
    local query_path=$1

    if [ -z "$query_path" ]; then
        return 0;
    fi

    echo $query_path;

    if [ ! -e "$query_path" ]; then
        echo "Error: La ruta especificada no existe: $query_path" >&2
        return 1
    fi
    find_dir=$(find -L $query_path -print 2>/dev/null )
    echo $find_dir

    file_or_dir=$(
        find -L $query_path -print 2>/dev/null | fzf --preview="[ -d {} ] && ls -F {} || (file {} | grep text >/dev/null && bat --color=always {} || file {})"
    )

    if [ -z "$file_or_dir" ]; then
        return 1
    elif [ -d "$file_or_dir" ]; then
        cd "$file_or_dir" || return
    else
        xdg-open "$file_or_dir" 2>/dev/null || open "$file_or_dir" 2>/dev/null || return
    fi
}

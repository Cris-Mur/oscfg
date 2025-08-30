" #############################################################################
" ##### Settings File ##### Cris-Mur #####
" #############################################################################
" #############################################################################
" ##### General Settings #####
source ./config/settings.vim
" ##### Editor Behaviour #####
source ./config/behaviour.vim
" ##### Keymap #####
source ./config/keymaps.vim
" ##### File format & sintax #####
source ./config/fileFormat.vim
" ##### Vim's plugin settings #####
if !isdirectory(expand("~/.vim/plugged"))
    echoerr "Cannot install plugins."
else
    if !fileredable(./config/plugins.vim)
                source ./config/plugins.vim
    else
        echoerr "Cannot found plugins config file."
    endif
endif

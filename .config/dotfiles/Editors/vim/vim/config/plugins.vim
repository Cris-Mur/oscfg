" #############################################################################
" ###################### Settings File ##### Cris-Mur #########################
" #############################################################################
" ################################ Plugings ###################################
" #############################################################################
call plug#begin('~/.vim/plugged')
" ##### Navigation ############################################################
" #############################################################################
Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" #############################################################################
" ##### AutoComplete & Syntax #################################################
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'yaegassy/coc-astro', {'do': 'yarn install --frozen-lockfile'}
Plug 'wuelnerdotexe/vim-astro'
" #############################################################################
" ##### Themes ################################################################
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" #############################################################################
call plug#end()
" #############################################################################
" ##### Plugin Settings #######################################################
let g:astro_stylus = 'enable'
let g:astro_typescript = 'enable'

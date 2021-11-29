syntax on

set mouse=a
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set showmode
set showcmd
set encoding=utf-8
set showmatch
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set clipboard=unnamed
set incsearch
set textwidth=79
let laststatus=2

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=black

call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'easymotion/vim-easymotion'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mbbill/undotree'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

let mapleader=" "
" Shortcuts
" Global
map <F8> :NERDTreeToggle<CR>
map <F9> :NERDTreeFind<CR>
map <F3> :tabnext<CR>
map <F2> :tabprevious<CR>
map <F1> :tabnew<CR>
map <F5> :UndotreeToggle<CR>
" Normal Mode
nmap cw ciw
nmap <Leader>s <Plug>(easymotion-s2)
nmap <Leader>w :w<CR>
nmap <Leader>q :q<CR>
nmap fs :Files<CR>
nmap <C-Up> :m-2<CR>
nmap <C-Down> :m+<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Insert Mode
imap <C-Up> <Esc>:m-2<CR>==gi
imap <C-Down> <Esc>:m+<CR>==gi

let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
let g:airline_theme='light'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'jsformatter'
let g:coc_global_extensions = [ 'coc-tsserver' ]


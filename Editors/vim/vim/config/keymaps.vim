" #############################################################################
" ######################## VIM's Vanilla KEYMAP file ##########################
" #############################################################################
let mapleader=" " " On Normal mode | activates another macro mode
" #############################################################################
" ### [keydown] [keyrecord] ###################################################
" ####################### TabWorking ##########################################
map <F2> :tabnew<CR>
map <F3> :tabprevious<CR>
map <F4> :tabnext<CR>
" ####################### Line Movement #######################################
nmap <C-Up> :m-2<CR>
nmap <C-Down> :m+<CR>
imap <C-Up> <Esc>:m-2<CR>==gi
imap <C-Down> <Esc>:m+<CR>==gi
" ####################### Text Replacement ####################################
nmap cw ciw
" ####################### FileWorking #########################################
" ### Safe File
nmap <Leader>w :w<CR> 
nmap <Leader>W :w<CR> 
" ### Close File
nmap <Leader>q :q<CR>
nmap <Leader>Q :q!<CR>
" ### Global Mode #############################################################
map <F5> :UndotreeToggle<CR>
" ### Normal Mode #############################################################
nmap <Leader>s <Plug>(easymotion-s2)
nmap fs :Files<CR>
" #############################################################################

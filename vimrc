set nu
set relativenumber
set nocompatible
syntax on
set mouse+=a
set wrap
set ruler
set showmatch
set showcmd
set wildmenu
set hlsearch
set incsearch
set ignorecase
set smartcase
set autoindent
set smartindent
set expandtab
set softtabstop=4
set shiftwidth=4
set scrolloff=8
set sidescrolloff=8
set cursorline
set cursorcolumn
set timeoutlen=500
set list
set listchars=space:·

inoremap jj <esc>
" map <space> leader
let mapleader=" "
nmap <Leader>wq :wq<CR>
nmap <Leader>w :w<CR>
nmap <Leader>Q :q!<CR>
nmap <Leader>q :q<CR>
nmap <Leader>p "+p
vnoremap Y "+y
noremap Q q
noremap q @
noremap n nzz
noremap N Nzz

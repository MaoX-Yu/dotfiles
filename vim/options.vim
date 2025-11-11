vim9script

g:mapleader = ' '
g:maplocalleader = '\'
g:qf_disable_statusline = true

syntax enable
filetype plugin on
filetype indent on

set autoindent
set autoread
set belloff=all
set breakindent
set cursorline
set encoding=utf8
set expandtab
set fileformats=unix,dos # Use Unix as the standard file type
set hidden # A buffer becomes hidden when it is abandoned
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set list
set listchars=nbsp:+,space:·,tab:»\ ,trail:-
set mouse=
set nobackup
set noshowmode
set noswapfile
set novisualbell
set nowritebackup
set number
set relativenumber
set ruler
set scrolloff=4
set shiftwidth=4
set shortmess=CoWITOtcFl
set showcmd
set showcmdloc=statusline
set showmatch
set sidescrolloff=8
set smartcase
set smartindent
set smarttab
set softtabstop=4
set splitbelow
set splitright
set tabstop=4
set timeoutlen=500
set wildmenu
set wildmode=full
set wildoptions=fuzzy,pum,tagfile

# Theme
set background=dark
if has('termguicolors')
    set termguicolors
endif
colorscheme catppuccin

if &term =~ 'xterm\|tmux\|win'
    # INSERT mode
    &t_SI = "\<esc>[6 q"
    # REPLACE mode
    &t_SR = "\<esc>[4 q"
    # NORMAL mode
    &t_EI = "\<esc>[2 q"
endif

# Grep
if executable('rg')
    set grepprg=rg\ --vimgrep\ -uu
    set grepformat^=%f:%l:%c:%m
endif

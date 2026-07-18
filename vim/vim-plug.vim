if empty(glob($MYVIMDIR . '/autoload/plug.vim'))
    silent execute '!curl -fLo ' . $MYVIMDIR . '/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" COC
call lsp#Setup()

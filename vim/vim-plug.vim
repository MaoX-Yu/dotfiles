if empty(glob($MYVIMDIR . '/autoload/plug.vim'))
    silent execute '!curl -fLo ' . $MYVIMDIR . '/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'yegappan/lsp'

call plug#end()

" LSP
autocmd User LspSetup call lsp#SetupLspOptions()
autocmd User LspSetup call lsp#SetupLspServers()
autocmd User LspSetup call lsp#SetupLspKeymaps()

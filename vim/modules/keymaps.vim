inoremap jj <esc>
tnoremap <esc><esc> <C-\\><C-n>
noremap! <C-l> <right>

inoremap , ,<C-g>u
inoremap . .<C-g>u
inoremap ; ;<C-g>u

inoremap <unique> ,, _
inoremap <unique> ,. &
inoremap <unique> ,/ *

nnoremap <expr> j v:count == 0 ? 'gj' : 'j'
xnoremap <expr> j v:count == 0 ? 'gj' : 'j'
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
xnoremap <expr> k v:count == 0 ? 'gk' : 'k'

noremap gs ^
noremap gh 0
noremap gl $

nnoremap U <C-r>

nnoremap [<space> O<esc>j
nnoremap ]<space> o<esc>k

noremap <leader>y "+y
noremap <leader>p "+p

nnoremap <esc> <cmd>noh<cr><esc>

nnoremap <C-q> <cmd>close<cr>
tnoremap <C-q> <cmd>close<cr>

nnoremap H <cmd>bp<cr>
nnoremap L <cmd>bn<cr>

noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l

vim9script

# Escape
inoremap jj <esc>
tnoremap <esc><esc> <C-\\><C-n>

# Add undo break-points
inoremap , ,<C-g>u
inoremap . .<C-g>u
inoremap ; ;<C-g>u

# Better inputs
inoremap <unique> ,, _
inoremap <unique> ,. &
inoremap <unique> ,/ *

# Better up/down
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'
xnoremap <expr> j v:count == 0 ? 'gj' : 'j'
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
xnoremap <expr> k v:count == 0 ? 'gk' : 'k'

# Move
noremap gs ^
noremap gh 0
noremap gl $
noremap! <C-l> <right>

# Remap redo
nnoremap U <C-r>

# Better indenting
vnoremap < <gv
vnoremap > >gv

nnoremap <expr> n get(v:, 'searchforward', 1) ? 'nzv' : 'Nzv'
xnoremap <expr> n get(v:, 'searchforward', 1) ? 'n' : 'N'
onoremap <expr> n get(v:, 'searchforward', 1) ? 'n' : 'N'
nnoremap <expr> N get(v:, 'searchforward', 1) ? 'Nzv' : 'nzv'
xnoremap <expr> N get(v:, 'searchforward', 1) ? 'N' : 'n'
onoremap <expr> N get(v:, 'searchforward', 1) ? 'N' : 'n'

# Add space line
nnoremap [<space> O<esc>j
nnoremap ]<space> o<esc>k

noremap <leader>y "+y
noremap <leader>p "+p

# Clear highlight
nnoremap <esc> <cmd>noh<cr><esc>

# Close
nnoremap <C-q> <cmd>close<cr>
tnoremap <C-q> <cmd>close<cr>

# Buffer
nnoremap H <cmd>bp<cr>
nnoremap L <cmd>bn<cr>

# Windows
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

# Resize window
nnoremap <C-Up> <cmd>resize +2<cr>
nnoremap <C-Down> <cmd>resize -2<cr>
nnoremap <C-Left> <cmd>vertical resize -2<cr>
nnoremap <C-Right> <cmd>vertical resize +2<cr>

# Tabs
nnoremap <leader><tab>l <cmd>tablast<cr>
nnoremap <leader><tab>o <cmd>tabonly<cr>
nnoremap <leader><tab>f <cmd>tabfirst<cr>
nnoremap <leader><tab><tab> <cmd>tabnew<cr>
nnoremap <leader><tab>] <cmd>tabnext<cr>
nnoremap <leader><tab>d <cmd>tabclose<cr>
nnoremap <leader><tab>[ <cmd>tabprevious<cr>

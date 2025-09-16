vim9script

# Escape
inoremap <unique> jj <esc>
tnoremap <unique> <esc><esc> <C-\\><C-n>

# Add undo break-points
inoremap <unique> , ,<C-g>u
inoremap <unique> . .<C-g>u
inoremap <unique> ; ;<C-g>u

# Better inputs
noremap! <unique> ,, _
noremap! <unique> ,. &
noremap! <unique> ,/ *

# Auto pairs
noremap! <unique> ( ()<left>
noremap! <unique> [ []<left>
noremap! <unique> { {}<left>
noremap! <unique> ' ''<left>
noremap! <unique> " ""<left>
noremap! <unique> ` ``<left>

# Better up/down
nnoremap <unique> <expr> j v:count == 0 ? 'gj' : 'j'
xnoremap <unique> <expr> j v:count == 0 ? 'gj' : 'j'
nnoremap <unique> <expr> k v:count == 0 ? 'gk' : 'k'
xnoremap <unique> <expr> k v:count == 0 ? 'gk' : 'k'

# Move
noremap <unique> gs ^
noremap <unique> gh 0
noremap <unique> gl $
noremap! <unique> <C-l> <right>

# Remap redo
nnoremap <unique> U <C-r>

# Better indenting
vnoremap <unique> < <gv
vnoremap <unique> > >gv

nnoremap <unique> <expr> n get(v:, 'searchforward', 1) ? 'nzv' : 'Nzv'
xnoremap <unique> <expr> n get(v:, 'searchforward', 1) ? 'n' : 'N'
onoremap <unique> <expr> n get(v:, 'searchforward', 1) ? 'n' : 'N'
nnoremap <unique> <expr> N get(v:, 'searchforward', 1) ? 'Nzv' : 'nzv'
xnoremap <unique> <expr> N get(v:, 'searchforward', 1) ? 'N' : 'n'
onoremap <unique> <expr> N get(v:, 'searchforward', 1) ? 'N' : 'n'

# Add space line
nnoremap <unique> [<space> O<esc>j
nnoremap <unique> ]<space> o<esc>k

noremap <unique> <leader>y "+y
noremap <unique> <leader>p "+p

# Clear highlight
nnoremap <unique> <esc> <cmd>noh<cr><esc>

# Close
nnoremap <unique> <C-q> <cmd>close<cr>
tnoremap <unique> <C-q> <cmd>close<cr>
nnoremap <unique> <expr> q &buftype == '' ? 'q' : '<cmd>close<cr>'

# Buffer
nnoremap <unique> H <cmd>bp<cr>
nnoremap <unique> L <cmd>bn<cr>

# Windows
nnoremap <unique> <C-j> <C-w>j
nnoremap <unique> <C-k> <C-w>k
nnoremap <unique> <C-h> <C-w>h
nnoremap <unique> <C-l> <C-w>l

# Resize window
nnoremap <unique> <C-Up> <cmd>resize +2<cr>
nnoremap <unique> <C-Down> <cmd>resize -2<cr>
nnoremap <unique> <C-Left> <cmd>vertical resize -2<cr>
nnoremap <unique> <C-Right> <cmd>vertical resize +2<cr>

# Tabs
nnoremap <unique> <leader><tab>l <cmd>tablast<cr>
nnoremap <unique> <leader><tab>o <cmd>tabonly<cr>
nnoremap <unique> <leader><tab>f <cmd>tabfirst<cr>
nnoremap <unique> <leader><tab><tab> <cmd>tabnew<cr>
nnoremap <unique> <leader><tab>] <cmd>tabnext<cr>
nnoremap <unique> <leader><tab>d <cmd>tabclose<cr>
nnoremap <unique> <leader><tab>[ <cmd>tabprevious<cr>

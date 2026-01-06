vim9script

import autoload '../autoload/keymaps.vim' as K

# Escape
inoremap jj <Esc>
tnoremap <Esc><Esc> <C-\><C-n>

# Add undo break-points
inoremap , ,<C-g>u
inoremap . .<C-g>u
inoremap ; ;<C-g>u

# Better inputs
noremap! ,, _
noremap! ,. &
noremap! ,/ *

# Auto pairs
noremap! ( ()<Left>
noremap! [ []<Left>
noremap! { {}<Left>
inoremap <expr> ) K.SmartBracket(')')
inoremap <expr> ] K.SmartBracket(']')
inoremap <expr> } K.SmartBracket('}')
inoremap <expr> ' K.SmartBracket("'")
inoremap <expr> " K.SmartBracket('"')
inoremap <expr> ` K.SmartBracket('`')
cnoremap <expr> ) K.SmartBracketCmd(')')
cnoremap <expr> ] K.SmartBracketCmd(']')
cnoremap <expr> } K.SmartBracketCmd('}')
cnoremap <expr> ' K.SmartBracketCmd("'")
cnoremap <expr> " K.SmartBracketCmd('"')
cnoremap <expr> ` K.SmartBracketCmd('`')

# Better up/down
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'
xnoremap <expr> j v:count == 0 ? 'gj' : 'j'
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
xnoremap <expr> k v:count == 0 ? 'gk' : 'k'

# Move
noremap gs ^
noremap gh 0
noremap gl $
noremap! <C-l> <Right>

# Remap redo
nnoremap U <C-r>
nnoremap <M-u> U

# Better indenting
vnoremap < <gv
vnoremap > >gv

# Add space line
nnoremap [<Space> <Cmd>call keymaps#AddBlank(1)<CR>
nnoremap ]<Space> <Cmd>call keymaps#AddBlank(0)<CR>

# Yank and paste
noremap <Leader>y "+y
noremap <Leader>p "+p

# Clear highlight
nnoremap <Esc> <Cmd>noh<CR><Esc>

# Close
nnoremap <C-q> <Cmd>close<CR>
tnoremap <C-q> <Cmd>close<CR>
nnoremap <expr> q &buftype == '' ? 'q' : '<Cmd>close<CR>'

# Buffer
nnoremap H <Cmd>bp<CR>
nnoremap L <Cmd>bn<CR>
nnoremap <Leader>bb <Cmd>e #<CR>
nnoremap <Leader>bc <Cmd>bd<CR>
nnoremap <Leader>bo <Cmd>call keymaps#CloseOtherBuffers()<CR>

# Windows
map <Leader>w <C-w>

# Resize window
nnoremap <C-Up> <Cmd>resize +2<CR>
nnoremap <C-Down> <Cmd>resize -2<CR>
nnoremap <C-Left> <Cmd>vertical resize -2<CR>
nnoremap <C-Right> <Cmd>vertical resize +2<CR>

# Tabs
nnoremap <Leader><Tab>] <Cmd>tablast<CR>
nnoremap <Leader><Tab>o <Cmd>tabonly<CR>
nnoremap <Leader><Tab>[ <Cmd>tabfirst<CR>
nnoremap <Leader><Tab><Tab> <Cmd>tabnew<CR>
nnoremap ]<Tab> <Cmd>tabnext<CR>
nnoremap <Leader><Tab>c <Cmd>tabclose<CR>
nnoremap [<Tab> <Cmd>tabprevious<CR>

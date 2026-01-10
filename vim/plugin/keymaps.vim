vim9script

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

# Better indenting
vnoremap < <gv
vnoremap > >gv

# Add space line
def AddBlank(offset: number)
    const line = line(".") + offset
    const col = col(".")
    const cmd = offset == 1 ? 'put!=repeat(nr2char(10), v:count1)' : 'put =repeat(nr2char(10), v:count1)'
    execute cmd
    cursor(line, col)
enddef
nnoremap [<Space> <Cmd>call <SID>AddBlank(1)<CR>
nnoremap ]<Space> <Cmd>call <SID>AddBlank(0)<CR>

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
def CloseOtherBuffers()
    const cur_buf = bufnr()
    const buffers = getbufinfo({buflisted: 1})

    for buf in buffers
        if buf.bufnr == cur_buf
            continue
        endif

        if buf.changed
            const prev_buf = bufnr()
            execute 'buffer' buf.bufnr
            const filename = expand('%:t')

            const choice = confirm(
                "Save changes to \"" .. filename .. "\"?",
                "&Yes\n&No\n&Cancel",
                1
            )

            if choice == 1
                write
                execute 'bdelete' buf.bufnr
            elseif choice == 2
                execute 'bwipeout!' buf.bufnr
            else
                execute 'buffer' prev_buf
                return
            endif

            if bufnr() != cur_buf && bufexists(cur_buf)
                execute 'buffer' cur_buf
            endif
        else
            execute 'bdelete' buf.bufnr
        endif
    endfor
enddef
nnoremap [b <Cmd>bp<CR>
nnoremap ]b <Cmd>bn<CR>
nnoremap [B <Cmd>bfirst<CR>
nnoremap ]B <Cmd>blast<CR>
nnoremap <Leader>bb <Cmd>e #<CR>
nnoremap <Leader>bc <Cmd>bd<CR>
nnoremap <Leader>bo <Cmd>call <SID>CloseOtherBuffers()<CR>

# Windows
map <Leader>w <C-w>

# Resize window
nnoremap <C-Up> <Cmd>resize +2<CR>
nnoremap <C-Down> <Cmd>resize -2<CR>
nnoremap <C-Left> <Cmd>vertical resize -2<CR>
nnoremap <C-Right> <Cmd>vertical resize +2<CR>

# Tabs
nnoremap [<Tab> <Cmd>tabprevious<CR>
nnoremap ]<Tab> <Cmd>tabnext<CR>
nnoremap <Leader><Tab>[ <Cmd>tabfirst<CR>
nnoremap <Leader><Tab>] <Cmd>tablast<CR>
nnoremap <Leader><Tab><Tab> <Cmd>tabnew<CR>
nnoremap <Leader><Tab>c <Cmd>tabclose<CR>
nnoremap <Leader><Tab>o <Cmd>tabonly<CR>

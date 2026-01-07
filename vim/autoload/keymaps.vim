vim9script

export def AddBlank(offset: number)
    const line = line(".") + offset
    const col = col(".")
    const cmd = offset == 1 ? 'put!=repeat(nr2char(10), v:count1)' : 'put =repeat(nr2char(10), v:count1)'
    execute cmd
    cursor(line, col)
enddef

export def CloseOtherBuffers()
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

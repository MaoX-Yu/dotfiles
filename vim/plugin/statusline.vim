vim9script

def GetFileinfo(): string
    var info = []

    const fileencoding = empty(&fileencoding) ? '-' : toupper(&fileencoding[0])
    add(info, fileencoding)

    const fileformat = &fileformat == 'dos' ? '\' : (&fileformat == 'mac' ? '/' : ':')
    add(info, fileformat)

    if !&modifiable || &readonly
        add(info, '%%')    
    else
        add(info, '-')
    endif
    if &modified
        add(info, '*')
    else
        add(info, '-')
    endif
    add(info, '-')

    return join(info, '')
enddef

def GetProgress(): string
    const first = line('w0')
    const total = line('$')
    if first == 1 && total <= winheight(0)
        return 'ALL'
    endif

    const cur = line('.')
    if cur == 1
        return "TOP"
    elseif cur == total
        return "BOT"
    else
        return $"{cur * 100 / total}%%"
    endif
enddef

def GetDiag(): string
    if !exists('g:loaded_lsp')
        return ''
    endif

    var count = lsp#lsp#ErrorCount()
    var diag = []
    if count.Error > 0
        add(diag, 'E:' .. count.Error)
    endif
    if count.Warn > 0
        add(diag, 'W:' .. count.Warn)
    endif
    if count.Hint > 0
        add(diag, 'H:' .. count.Hint)
    endif
    if count.Info > 0
        add(diag, 'I:' .. count.Info)
    endif

    if len(diag) == 0
        return ''
    endif

    return join(diag, ' ') .. '  '
enddef

g:STL = {
    GetFileinfo: GetFileinfo,
    GetProgress: GetProgress,
    GetDiag: GetDiag,
}

set stl=
set stl+=\ %{%STL.GetFileinfo()%}
set stl+=\ \ %f\ %h%w
set stl+=%<%=
set stl+=%S\ \ 
set stl+=%{%STL.GetDiag()%}
set stl+=%{%&filetype==''?''\:'%{&filetype}\ \ '%}
set stl+=%l:%c%V
set stl+=\ \ %{%STL.GetProgress()%}\ 

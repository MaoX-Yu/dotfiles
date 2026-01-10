vim9script

def GetFileinfo(): string
    const fileencoding = empty(&fileencoding) ? '-' : toupper(&fileencoding[0])
    const fileformat = &fileformat == 'dos' ? '\' : (&fileformat == 'mac' ? '/' : ':')
    var filestat = '--'
    if !&modifiable || &readonly
        if &modified
            filestat = '%%*'
        else
            filestat = '%%%%'
        endif
    else
        if &modified
            filestat = '**'
        endif
    endif

    return fileencoding .. fileformat .. filestat
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

g:STL = {
    GetFileinfo: GetFileinfo,
    GetProgress: GetProgress,
}

set stl=
set stl+=\ %{%STL.GetFileinfo()%}
set stl+=\ \ %f\ %h%w
set stl+=%<%=
set stl+=%S\ \ 
set stl+=%{%&filetype==''?''\:'%{&filetype}\ \ '%}
set stl+=%l:%c%V
set stl+=\ \ %{%STL.GetProgress()%}\ 

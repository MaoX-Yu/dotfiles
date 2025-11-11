vim9script

if exists('g:loaded_mao_stl')
    finish
endif
g:loaded_mao_stl = 1

import autoload 'stl.vim' as utils

def GetMode(): string
    const current_mode = mode()
    return get(utils.mode_names, current_mode, 'U')
enddef

def GetFileinfo(): string
    const fileencoding = empty(&fileencoding) ? '-' : toupper(&fileencoding[0])
    const encoding = empty(&encoding) ? '-' : toupper(&encoding[0])
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

    return fileencoding .. encoding .. fileformat .. filestat
enddef

g:STL = {
    GetMode: GetMode,
    GetFileinfo: GetFileinfo,
}

set stl=
set stl+=\ %{%STL.GetMode()%}
set stl+=\ \ %{%STL.GetFileinfo()%}
set stl+=\ \ %f\ %h%w
set stl+=%<%=
set stl+=%S\ \ 
set stl+=%{%&filetype==''?''\:'%{&filetype}\ \ '%}
set stl+=%l:%c%V\ \ %P\ 

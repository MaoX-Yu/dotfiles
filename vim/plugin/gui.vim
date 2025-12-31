vim9script

if !has('gui_running')
    finish
endif

set guifont=Maple\ Mono\ NF\ CN:h14

if has('win32') || has('win64')
    autocmd GUIEnter * simalt ~x
else
    autocmd GUIEnter * set lines=999 columns=999
endif

if exists('g:disable_simple_gui')
    finish
endif

set guioptions=

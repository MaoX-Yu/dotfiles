vim9script

if exists('g:loaded_mao_gui')
    finish
endif
g:loaded_mao_gui = 1

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

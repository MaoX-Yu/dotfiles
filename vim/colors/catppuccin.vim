vim9script

hi clear
if exists('syntax_on')
    syntax reset
endif

g:colors_name = 'catppuccin'
set t_Co=256

var p = {}

p.rosewater = '#F4DBD6'
p.flamingo = '#F0C6C6'
p.pink = '#F5BDE6'
p.mauve = '#C6A0F6'
p.red = '#ED8796'
p.maroon = '#EE99A0'
p.peach = '#F5A97F'
p.yellow = '#EED49F'
p.green = '#A6DA95'
p.teal = '#8BD5CA'
p.sky = '#91D7E3'
p.sapphire = '#7DC4E4'
p.blue = '#8AADF4'
p.lavender = '#B7BDF8'

p.text = '#CAD3F5'
p.subtext1 = '#B8C0E0'
p.subtext0 = '#A5ADCB'
p.overlay2 = '#939AB7'
p.overlay1 = '#8087A2'
p.overlay0 = '#6E738D'
p.surface2 = '#5B6078'
p.surface1 = '#494D64'
p.surface0 = '#363A4F'

p.base = '#24273A'
p.mantle = '#1E2030'
p.crust = '#181926'

exe 'hi! Normal'           'guifg=' .. p.text     'guibg=' .. p.base      'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! Visual'           'guifg=NONE'           'guibg=' .. p.surface1  'gui=bold'        'guisp=NONE' 'cterm=bold'
exe 'hi! Conceal'          'guifg=' .. p.overlay1 'guibg=NONE'            'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! ColorColumn'      'guifg=NONE'           'guibg=' .. p.surface0  'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! CurSearch'        'guifg=' .. p.mantle   'guibg=' .. p.red       'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! Cursor'           'guifg=' .. p.base     'guibg=' .. p.rosewater 'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! lCursor'          'guifg=' .. p.base     'guibg=' .. p.rosewater 'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! CursorIM'         'guifg=' .. p.base     'guibg=' .. p.rosewater 'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! CursorColumn'     'guifg=NONE'           'guibg=' .. p.mantle    'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! CursorLine'       'guifg=NONE'           'guibg=' .. p.surface0  'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! Directory'        'guifg=' .. p.blue     'guibg=NONE'            'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! DiffAdd'          'guifg=' .. p.base     'guibg=' .. p.green     'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! DiffChange'       'guifg=' .. p.base     'guibg=' .. p.yellow    'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! DiffDelete'       'guifg=' .. p.base     'guibg=' .. p.red       'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! DiffText'         'guifg=' .. p.base     'guibg=' .. p.blue      'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! EndOfBuffer'      'guifg=' .. p.base     'guibg=NONE'            'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! ErrorMsg'         'guifg=' .. p.red      'guibg=NONE'            'gui=bold,italic' 'guisp=NONE' 'cterm=bold,italic'
exe 'hi! VertSplit'        'guifg=' .. p.crust    'guibg=NONE'            'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! Folded'           'guifg=' .. p.blue     'guibg=' .. p.surface1  'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! FoldColumn'       'guifg=' .. p.overlay0 'guibg=' .. p.base      'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! SignColumn'       'guifg=' .. p.surface1 'guibg=' .. p.base      'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! IncSearch'        'guifg=' .. p.mantle   'guibg=' .. p.pink      'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! CursorLineNR'     'guifg=' .. p.lavender 'guibg=NONE'            'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! LineNr'           'guifg=' .. p.surface1 'guibg=NONE'            'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! MatchParen'       'guifg=' .. p.peach    'guibg=NONE'            'gui=bold'        'guisp=NONE' 'cterm=bold'
exe 'hi! ModeMsg'          'guifg=' .. p.text     'guibg=NONE'            'gui=bold'        'guisp=NONE' 'cterm=bold'
exe 'hi! MoreMsg'          'guifg=' .. p.blue     'guibg=NONE'            'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! NonText'          'guifg=' .. p.overlay0 'guibg=NONE'            'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! Pmenu'            'guifg=' .. p.overlay2 'guibg=' .. p.mantle    'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! PmenuSel'         'guifg=NONE'           'guibg=' .. p.surface0  'gui=bold'        'guisp=NONE' 'cterm=bold'
exe 'hi! PmenuMatch'       'guifg=' .. p.pink     'guibg=NONE'            'gui=bold'        'guisp=NONE' 'cterm=bold'
exe 'hi! PmenuMatchSel'    'guifg=' .. p.pink     'guibg=' .. p.surface0  'gui=bold'        'guisp=NONE' 'cterm=bold'
exe 'hi! PmenuSbar'        'guifg=NONE'           'guibg=' .. p.surface0  'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! PmenuThumb'       'guifg=NONE'           'guibg=' .. p.overlay0  'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! Question'         'guifg=' .. p.blue     'guibg=NONE'            'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! QuickFixLine'     'guifg=NONE'           'guibg=' .. p.surface1  'gui=bold'        'guisp=NONE' 'cterm=bold'
exe 'hi! Search'           'guifg=' .. p.pink     'guibg=' .. p.surface1  'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! SpecialKey'       'guifg=' .. p.surface1 'guibg=NONE'            'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! SpellBad'         'guifg=' .. p.base     'guibg=' .. p.red       'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! SpellCap'         'guifg=' .. p.base     'guibg=' .. p.yellow    'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! SpellLocal'       'guifg=' .. p.base     'guibg=' .. p.blue      'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! SpellRare'        'guifg=' .. p.base     'guibg=' .. p.green     'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! StatusLine'       'guifg=' .. p.text     'guibg=' .. p.mantle    'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! StatusLineNC'     'guifg=' .. p.surface1 'guibg=' .. p.mantle    'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! StatusLineTerm'   'guifg=' .. p.text     'guibg=' .. p.mantle    'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! StatusLineTermNC' 'guifg=' .. p.surface1 'guibg=' .. p.mantle    'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! TabLine'          'guifg=' .. p.surface1 'guibg=' .. p.mantle    'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! TabLineFill'      'guifg=NONE'           'guibg=' .. p.mantle    'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! TabLineSel'       'guifg=' .. p.green    'guibg=' .. p.surface1  'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! Title'            'guifg=' .. p.blue     'guibg=NONE'            'gui=bold'        'guisp=NONE' 'cterm=bold'
exe 'hi! VisualNOS'        'guifg=NONE'           'guibg=' .. p.surface1  'gui=bold'        'guisp=NONE' 'cterm=bold'
exe 'hi! WarningMsg'       'guifg=' .. p.yellow   'guibg=NONE'            'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! WildMenu'         'guifg=NONE'           'guibg=' .. p.overlay0  'gui=NONE'        'guisp=NONE' 'cterm=NONE'

exe 'hi! Added'            'guifg=' .. p.green    'guibg=NONE'            'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! Changed'          'guifg=' .. p.sky      'guibg=NONE'            'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! Character'        'guifg=' .. p.teal     'guibg=NONE'            'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! Comment'          'guifg=' .. p.overlay0 'guibg=NONE'            'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! Constant'         'guifg=' .. p.peach    'guibg=NONE'            'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! Error'            'guifg=' .. p.red      'guibg=NONE'            'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! Function'         'guifg=' .. p.blue     'guibg=NONE'            'gui=italic'      'guisp=NONE' 'cterm=italic'
exe 'hi! Identifier'       'guifg=' .. p.flamingo 'guibg=NONE'            'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! Label'            'guifg=' .. p.sapphire 'guibg=NONE'            'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! Operator'         'guifg=' .. p.sky      'guibg=NONE'            'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! PreProc'          'guifg=' .. p.pink     'guibg=NONE'            'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! Removed'          'guifg=' .. p.maroon   'guibg=NONE'            'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! Special'          'guifg=' .. p.pink     'guibg=NONE'            'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! Statement'        'guifg=' .. p.mauve    'guibg=NONE'            'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! String'           'guifg=' .. p.green    'guibg=NONE'            'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! Structure'        'guifg=' .. p.yellow   'guibg=NONE'            'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! Todo'             'guifg=' .. p.base     'guibg=' .. p.flamingo  'gui=bold'        'guisp=NONE' 'cterm=bold'
exe 'hi! Type'             'guifg=' .. p.yellow   'guibg=NONE'            'gui=italic'      'guisp=NONE' 'cterm=italic'
exe 'hi! Underlined'       'guifg=' .. p.text     'guibg=' .. p.base      'gui=underline'   'guisp=NONE' 'cterm=underline'
exe 'hi! debugBreakpoint'  'guifg=' .. p.overlay0 'guibg=' .. p.base      'gui=NONE'        'guisp=NONE' 'cterm=NONE'
exe 'hi! debugPC'          'guifg=NONE'           'guibg=' .. p.crust     'gui=NONE'        'guisp=NONE' 'cterm=NONE'

hi! link Boolean Constant
hi! link Conditional Statement
hi! link Debug Special
hi! link Define PreProc
hi! link Delimiter Special
hi! link Exception Statement
hi! link Float Constant
hi! link Ignore Comment
hi! link Include Statement
hi! link Keyword Statement
hi! link Macro Statement
hi! link Number Constant
hi! link PreCondit PreProc
hi! link Repeat Statement
hi! link SpecialChar Special
hi! link SpecialComment Special
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link StorageClass Structure
hi! link Tag Special
hi! link Terminal Normal
hi! link Typedef Type

# Set terminal colors for playing well with plugins like fzf
g:terminal_ansi_colors = [
    p.surface1, p.red, p.green, p.yellow, p.blue, p.pink, p.teal, p.subtext1,
    p.surface2, p.red, p.green, p.yellow, p.blue, p.pink, p.teal, p.subtext0
]

vim9script

hi clear
if exists('syntax_on')
    syntax reset
endif

g:colors_name = 'catppuccin'
set t_Co=256

var p = {}

p.rosewater = "#F4DBD6"
p.flamingo = "#F0C6C6"
p.pink = "#F5BDE6"
p.mauve = "#C6A0F6"
p.red = "#ED8796"
p.maroon = "#EE99A0"
p.peach = "#F5A97F"
p.yellow = "#EED49F"
p.green = "#A6DA95"
p.teal = "#8BD5CA"
p.sky = "#91D7E3"
p.sapphire = "#7DC4E4"
p.blue = "#8AADF4"
p.lavender = "#B7BDF8"

p.text = "#CAD3F5"
p.subtext1 = "#B8C0E0"
p.subtext0 = "#A5ADCB"
p.overlay2 = "#939AB7"
p.overlay1 = "#8087A2"
p.overlay0 = "#6E738D"
p.surface2 = "#5B6078"
p.surface1 = "#494D64"
p.surface0 = "#363A4F"

p.base = "#24273A"
p.mantle = "#1E2030"
p.crust = "#181926"

def Hi(group: string, guisp: string, guifg: string, guibg: string, gui: string, cterm: string)
    var cmd = ""
    if guisp != ""
        cmd ..= " guisp=" .. guisp
    endif
    if guifg != ""
        cmd ..= " guifg=" .. guifg
    endif
    if guibg != ""
        cmd ..= " guibg=" .. guibg
    endif
    if gui != ""
        cmd ..= " gui=" .. gui
    endif
    if cterm != ""
        cmd ..= " cterm=" .. cterm
    endif
    if cmd != ""
        execute "hi " .. group .. cmd
    endif
enddef

Hi("Normal", "NONE", p.text, p.base, "NONE", "NONE")
Hi("Visual", "NONE", "NONE", p.surface1, "bold", "bold")
Hi("Conceal", "NONE", p.overlay1, "NONE", "NONE", "NONE")
Hi("ColorColumn", "NONE", "NONE", p.surface0, "NONE", "NONE")
Hi("CurSearch", "NONE", p.mantle, p.red, "NONE", "NONE")
Hi("Cursor", "NONE", p.base, p.rosewater, "NONE", "NONE")
Hi("lCursor", "NONE", p.base, p.rosewater, "NONE", "NONE")
Hi("CursorIM", "NONE", p.base, p.rosewater, "NONE", "NONE")
Hi("CursorColumn", "NONE", "NONE", p.mantle, "NONE", "NONE")
Hi("CursorLine", "NONE", "NONE", p.surface0, "NONE", "NONE")
Hi("Directory", "NONE", p.blue, "NONE", "NONE", "NONE")
Hi("DiffAdd", "NONE", p.base, p.green, "NONE", "NONE")
Hi("DiffChange", "NONE", p.base, p.yellow, "NONE", "NONE")
Hi("DiffDelete", "NONE", p.base, p.red, "NONE", "NONE")
Hi("DiffText", "NONE", p.base, p.blue, "NONE", "NONE")
Hi("EndOfBuffer", "NONE", p.base, "NONE", "NONE", "NONE")
Hi("ErrorMsg", "NONE", p.red, "NONE", "bolditalic", "bold,italic")
Hi("VertSplit", "NONE", p.crust, "NONE", "NONE", "NONE")
Hi("Folded", "NONE", p.blue, p.surface1, "NONE", "NONE")
Hi("FoldColumn", "NONE", p.overlay0, p.base, "NONE", "NONE")
Hi("SignColumn", "NONE", p.surface1, p.base, "NONE", "NONE")
Hi("IncSearch", "NONE", p.mantle, p.pink, "NONE", "NONE")
Hi("CursorLineNR", "NONE", p.lavender, "NONE", "NONE", "NONE")
Hi("LineNr", "NONE", p.surface1, "NONE", "NONE", "NONE")
Hi("MatchParen", "NONE", p.peach, "NONE", "bold", "bold")
Hi("ModeMsg", "NONE", p.text, "NONE", "bold", "bold")
Hi("MoreMsg", "NONE", p.blue, "NONE", "NONE", "NONE")
Hi("NonText", "NONE", p.overlay0, "NONE", "NONE", "NONE")
Hi("Pmenu", "NONE", p.overlay2, p.mantle, "NONE", "NONE")
Hi("PmenuSel", "NONE", "NONE", p.surface0, "bold", "bold")
Hi("PmenuMatch", "NONE", p.pink, "NONE", "bold", "bold")
Hi("PmenuMatchSel", "NONE", p.pink, p.surface0, "bold", "bold")
Hi("PmenuSbar", "NONE", "NONE", p.surface0, "NONE", "NONE")
Hi("PmenuThumb", "NONE", "NONE", p.overlay0, "NONE", "NONE")
Hi("Question", "NONE", p.blue, "NONE", "NONE", "NONE")
Hi("QuickFixLine", "NONE", "NONE", p.surface1, "bold", "bold")
Hi("Search", "NONE", p.pink, p.surface1, "NONE", "NONE")
Hi("SpecialKey", "NONE", p.surface1, "NONE", "NONE", "NONE")
Hi("SpellBad", "NONE", p.base, p.red, "NONE", "NONE")
Hi("SpellCap", "NONE", p.base, p.yellow, "NONE", "NONE")
Hi("SpellLocal", "NONE", p.base, p.blue, "NONE", "NONE")
Hi("SpellRare", "NONE", p.base, p.green, "NONE", "NONE")
Hi("StatusLine", "NONE", p.text, p.mantle, "NONE", "NONE")
Hi("StatusLineNC", "NONE", p.surface1, p.mantle, "NONE", "NONE")
Hi("StatusLineTerm", "NONE", p.text, p.mantle, "NONE", "NONE")
Hi("StatusLineTermNC", "NONE", p.surface1, p.mantle, "NONE", "NONE")
Hi("TabLine", "NONE", p.surface1, p.mantle, "NONE", "NONE")
Hi("TabLineFill", "NONE", "NONE", p.mantle, "NONE", "NONE")
Hi("TabLineSel", "NONE", p.green, p.surface1, "NONE", "NONE")
Hi("Title", "NONE", p.blue, "NONE", "bold", "bold")
Hi("VisualNOS", "NONE", "NONE", p.surface1, "bold", "bold")
Hi("WarningMsg", "NONE", p.yellow, "NONE", "NONE", "NONE")
Hi("WildMenu", "NONE", "NONE", p.overlay0, "NONE", "NONE")

Hi("Added", "NONE", p.green, "NONE", "NONE", "NONE")
Hi("Changed", "NONE", p.sky, "NONE", "NONE", "NONE")
Hi("Character", "NONE", p.teal, "NONE", "NONE", "NONE")
Hi("Comment", "NONE", p.overlay0, "NONE", "NONE", "NONE")
Hi("Constant", "NONE", p.peach, "NONE", "NONE", "NONE")
Hi("Error", "NONE", p.red, "NONE", "NONE", "NONE")
Hi("Function", "NONE", p.blue, "NONE", "italic", "italic")
Hi("Identifier", "NONE", p.flamingo, "NONE", "NONE", "NONE")
Hi("Label", "NONE", p.sapphire, "NONE", "NONE", "NONE")
Hi("Operator", "NONE", p.sky, "NONE", "NONE", "NONE")
Hi("PreProc", "NONE", p.pink, "NONE", "NONE", "NONE")
Hi("Removed", "NONE", p.maroon, "NONE", "NONE", "NONE")
Hi("Special", "NONE", p.pink, "NONE", "NONE", "NONE")
Hi("Statement", "NONE", p.mauve, "NONE", "NONE", "NONE")
Hi("String", "NONE", p.green, "NONE", "NONE", "NONE")
Hi("Structure", "NONE", p.yellow, "NONE", "NONE", "NONE")
Hi("Todo", "NONE", p.base, p.flamingo, "bold", "bold")
Hi("Type", "NONE", p.yellow, "NONE", "italic", "italic")
Hi("Underlined", "NONE", p.text, p.base, "underline", "underline")
Hi("debugBreakpoint", "NONE", p.overlay0, p.base, "NONE", "NONE")
Hi("debugPC", "NONE", "NONE", p.crust, "NONE", "NONE")

hi link Boolean Constant
hi link Conditional Statement
hi link Debug Special
hi link Define PreProc
hi link Delimiter Special
hi link Exception Statement
hi link Float Constant
hi link Ignore Comment
hi link Include Statement
hi link Keyword Statement
hi link Macro Statement
hi link Number Constant
hi link PreCondit PreProc
hi link Repeat Statement
hi link SpecialChar Special
hi link SpecialComment Special
hi link StatusLineTerm StatusLine
hi link StatusLineTermNC StatusLineNC
hi link StorageClass Structure
hi link Tag Special
hi link Terminal Normal
hi link Typedef Type

# Set terminal colors for playing well with plugins like fzf
g:terminal_ansi_colors = [
    p.surface1, p.red, p.green, p.yellow, p.blue, p.pink, p.teal, p.subtext1,
    p.surface2, p.red, p.green, p.yellow, p.blue, p.pink, p.teal, p.subtext0
]

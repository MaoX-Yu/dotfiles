-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local g = vim.g
local o = vim.opt

o.autoread = true
o.breakindent = true
o.cmdheight = 0
o.expandtab = true -- use space replace tab
o.fillchars = { fold = " ", foldopen = "", foldsep = " ", foldclose = "" }
o.foldcolumn = "1"
o.foldlevel = 99
o.foldlevelstart = 99
o.hidden = true
o.hlsearch = true
o.incsearch = true
o.linebreak = true
o.list = true
o.listchars = { nbsp = "+", space = "·", tab = "» ", trail = "-" }
o.mouse = "" -- disable mouse
o.pumblend = 0
o.scrolloff = 4
o.shiftwidth = 4
o.showcmd = true
o.showmatch = true
o.showtabline = 1
o.sidescrolloff = 8
o.smarttab = true
o.softtabstop = -1
o.swapfile = false
o.tabstop = 4
o.wildmenu = true
o.winblend = 0
o.wrap = false

g.lazyvim_python_lsp = "basedpyright"
g.lazyvim_python_ruff = "ruff"
g.qf_disable_statusline = true
g.trouble_lualine = false

if vim.fn.executable("nu") == 1 then
  o.shell = "nu"
  o.shellcmdflag = "--stdin --no-newline -c"
  o.shellpipe = "| complete | update stderr { ansi strip } | tee { get stderr | save --force --raw %s } | into record"
  o.shellredir = "out+err> %s"
  o.shellxescape = ""
  o.shellquote = ""
  o.shellxquote = ""
  o.shelltemp = false
elseif LazyVim.is_win() then
  LazyVim.terminal.setup("pwsh")
end

vim.diagnostic.config({
  virtual_lines = { current_line = true },
})

-- Neovide
if g.neovide then
  -- options.opt.guifont = "JetbrainsMono Nerd Font:h14"
  o.guifont = "Maple Mono NF CN:h14"
  g.neovide_hide_mouse_when_typing = true
end

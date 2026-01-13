local g = vim.g
local o = vim.o

g.autoformat = true
g.mapleader = " "
g.maplocalleader = "\\"
g.qf_disable_statusline = true

o.breakindent = true
o.clipboard = "unnamedplus"
o.cmdheight = 1
o.completeitemalign = "kind,abbr,menu"
o.completeopt = "menu,menuone,noselect,fuzzy,popup"
o.confirm = true
o.cursorline = true
o.expandtab = true -- use space replace tab
o.fileformats = "unix,dos"
o.fillchars = "fold: ,foldclose:,foldopen:,foldsep: "
o.foldcolumn = "1"
o.foldlevel = 99
o.foldlevelstart = 99
o.formatoptions = "jcroqlnt" -- tcqj
o.hidden = true
o.hlsearch = true
o.ignorecase = true
o.inccommand = "split"
o.jumpoptions = "view"
o.laststatus = 3
o.linebreak = true
o.list = true
o.listchars = "nbsp:+,space:·,tab:» ,trail:-"
o.mouse = "" -- disable mouse
o.number = true
o.pumblend = 0
o.pumborder = "none"
o.pumheight = 10
o.pummaxwidth = 80
o.relativenumber = true
o.ruler = false
o.scrolloff = 4
o.shiftwidth = 4
o.shortmess = "ltToOCFWI"
o.showcmdloc = "statusline"
o.showmode = true
o.sidescrolloff = 8
o.signcolumn = "yes"
o.smartcase = true
o.smartindent = true
o.smarttab = true
o.smoothscroll = true
o.softtabstop = -1
o.splitbelow = true
o.splitright = true
o.swapfile = false
o.tabstop = 4
o.termguicolors = true
o.timeoutlen = g.vscode and 1000 or 300
o.undofile = true
o.updatetime = 300
o.virtualedit = "block"
o.wildmenu = true
o.winblend = 0
o.winborder = "rounded"
o.wrap = false

-- Extui
if vim.fn.has("nvim-0.12") == 1 then
  require("vim._extui").enable({})
end

-- Disable deprecated warning
---@diagnostic disable-next-line
vim.deprecate = function() end

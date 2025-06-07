local g = vim.g
local o = vim.o

g.autoformat = true
g.mapleader = " "
g.maplocalleader = "\\"
g.qf_disable_statusline = true

vim.schedule(function()
  o.clipboard = "unnamedplus"
end)

o.breakindent = true
o.cmdheight = 0
o.completeopt = "menu,menuone,noselect"
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
o.pumheight = 10
o.relativenumber = true
o.ruler = false
o.scrolloff = 4
o.shiftwidth = 4
o.shortmess = "CoWITOtcFl"
o.showmode = false
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
o.wrap = false

-- Shell
if vim.fn.executable("nu") == 1 then
  o.shell = "nu"
  o.shellcmdflag = "--stdin --no-newline -c"
  o.shellpipe =
    "| complete | update stderr { ansi strip } | tee { if ($in.stderr | is-empty) { get stdout } else { get stderr } | save --force --raw %s } | into record"
  o.shellredir = "out+err> %s"
  o.shellxescape = ""
  o.shellquote = ""
  o.shellxquote = ""
  o.shelltemp = false
elseif vim.uv.os_uname().sysname:find("Windows") then
  if vim.fn.executable("pwsh") == 1 then
    o.shell = "pwsh"
  else
    o.shell = "powershell"
  end
  o.shellcmdflag =
    "-NoLogo -NonInteractive -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';$PSStyle.OutputRendering='plaintext';Remove-Alias -Force -ErrorAction SilentlyContinue tee;"
  o.shellpipe = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
  o.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
  o.shellquote = ""
  o.shellxquote = ""
end

-- Disable deprecated warning
---@diagnostic disable-next-line
vim.deprecate = function() end

-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local options = {
  opt = {
    autoread = true,
    breakindent = true,
    cmdheight = 1,
    expandtab = true, -- use space replace tab
    hidden = true,
    hlsearch = true,
    incsearch = true,
    linebreak = true,
    list = true,
    listchars = { nbsp = "+", space = "·", tab = "  ", trail = "-" },
    mouse = "", -- disable mouse
    pumblend = 0,
    scrolloff = 4,
    shiftwidth = 4,
    showcmd = true,
    showmatch = true,
    showtabline = 2,
    sidescrolloff = 8,
    smarttab = true,
    softtabstop = -1,
    swapfile = false,
    tabstop = 4,
    wildmenu = true,
    winblend = 0,
    wrap = false,
  },
  g = {
    lazyvim_python_lsp = "basedpyright",
    lazyvim_python_ruff = "ruff",
    qf_disable_statusline = true,
    trouble_lualine = false,
  },
}

if vim.fn.executable("nu") then
  options.opt.shell = "nu"
  options.opt.shellcmdflag = "--stdin --no-newline -c"
  options.opt.shellpipe =
    "| complete | update stderr { ansi strip } | tee { get stderr | save --force --raw %s } | into record"
  options.opt.shellredir = "out+err> %s"
  options.opt.shellxescape = ""
  options.opt.shellquote = ""
  options.opt.shellxquote = ""
  options.opt.shelltemp = false
elseif LazyVim.is_win() then
  LazyVim.terminal.setup("pwsh")
end

-- Neovide
if vim.g.neovide then
  -- options.opt.guifont = "JetbrainsMono Nerd Font:h14"
  options.opt.guifont = "Maple Mono NF CN:h14"
  options.g.neovide_hide_mouse_when_typing = true
end

for scope, tbl in pairs(options) do
  for setting, val in pairs(tbl) do
    vim[scope][setting] = val
  end
end

-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local U = require("utils")

local options = {
  opt = {
    autoread = true,
    backup = false,
    breakindent = true,
    cmdheight = 1,
    expandtab = true, -- use space replace tab
    hidden = true,
    hlsearch = true,
    incsearch = true,
    linebreak = true,
    list = true,
    listchars = "nbsp:+,space:·,tab:  ,trail:-",
    mouse = "", -- disable mouse
    pumblend = 0,
    scrolloff = 8,
    shiftwidth = 4,
    showcmd = true,
    showmatch = true,
    showtabline = 2,
    sidescrolloff = 8,
    softtabstop = -1,
    swapfile = false,
    tabstop = 4,
    wildmenu = true,
    winblend = 0,
    wrap = false,
    writebackup = false,
  },
  g = {
    mapleader = " ", -- leader key
    lazyvim_python_lsp = "basedpyright",
    lazyvim_python_ruff = "ruff",
    trouble_lualine = false,
  },
}

-- Neovide
if vim.g.neovide then
  -- options.opt.guifont = "JetbrainsMono Nerd Font:h14"
  options.opt.guifont = "Maple Mono NF CN:h14"
  options.g.neovide_hide_mouse_when_typing = true
end

-- Filetype
vim.filetype.add({
  filename = {
    ["go.mod"] = "gomod",
    ["go.sum"] = "gosum",
    ["go.work"] = "gowork",
  },
})

U.load_opts(options)

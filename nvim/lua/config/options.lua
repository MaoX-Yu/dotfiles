-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local options = {
  opt = {
    autoread = true,
    backup = false,
    breakindent = true,
    cmdheight = 0,
    expandtab = true, -- use space replace tab
    hidden = true,
    hlsearch = true,
    incsearch = true,
    linebreak = true,
    list = true,
    mouse = "", -- disable mouse
    scrolloff = 8,
    showcmd = true,
    showmatch = true,
    showtabline = 2,
    sidescrolloff = 8,
    swapfile = false,
    wildmenu = true,
    wrap = false,
    writebackup = false,
  },
  g = {
    mapleader = " ", -- leader key
  },
}

vim.opt.listchars:append("space:·")

-- Neovide
if vim.g.neovide then
  -- options.opt.guifont = "JetbrainsMono Nerd Font:h14"
  options.opt.guifont = "Maple Mono SC NF:h14"
  options.g.neovide_hide_mouse_when_typing = true
end

for scope, table in pairs(options) do
  for setting, value in pairs(table) do
    vim[scope][setting] = value
  end
end

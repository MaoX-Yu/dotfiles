-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Use <tab> in golang
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go", "gomod", "gosum", "gowork" },
  callback = function()
    vim.opt.expandtab = false
  end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.o.rtp = lazypath .. "," .. vim.o.rtp

-- TODO: Remove after fixed. See: https://github.com/folke/lazy.nvim/issues/1951
vim.api.nvim_create_autocmd("FileType", {
  desc = "User: fix backdrop for lazy window",
  pattern = "lazy_backdrop",
  group = vim.api.nvim_create_augroup("lazy.nvim.fix", { clear = true }),
  callback = function(ctx)
    local win = vim.fn.win_findbuf(ctx.buf)[1] or 0
    vim.api.nvim_win_set_config(win, { border = "none" })
  end,
})

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
    { import = "plugins.lang" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "catppuccin" } },
  -- automatically check for plugin updates
  checker = { enabled = false },
})

vim.cmd.colorscheme("catppuccin")

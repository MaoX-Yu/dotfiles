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

-- Start picker with directory
vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("picker_start_directory", { clear = true }),
  desc = "Start picker with directory",
  once = true,
  callback = function()
    local basename = vim.fn.argv(0)
    local stats = vim.uv.fs_stat(basename)
    if stats and stats.type == "directory" then
      vim.cmd("bd") -- close netrw
      local current_dir = vim.fn.expand("%:p:h") .. "/" .. basename
      if LazyVim.has("fzf-lua") then
        require("fzf-lua").files({ cwd = current_dir })
      else
        require("telescope.builtin").find_files({ cwd = current_dir })
      end
    end
  end,
})

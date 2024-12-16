local au = vim.api.nvim_create_autocmd

local function augroup(name)
  return vim.api.nvim_create_augroup("myau_" .. name, { clear = true })
end

-- Start picker with directory
au("VimEnter", {
  group = augroup("picker_start_directory"),
  desc = "Start picker with directory",
  once = true,
  callback = function()
    local ok, fzf = pcall(require, "fzf-lua")
    if not ok then
      return
    end
    local basename = vim.fn.argv(0)
    local stats = vim.uv.fs_stat(basename)
    if stats and stats.type == "directory" then
      vim.cmd("bd") -- close netrw
      local current_dir = vim.fn.expand("%:p:h") .. "/" .. basename
      fzf.files({ cwd = current_dir })
    end
  end,
})

-- Highlight on yank
au("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})

-- Resize splits if window got resized
au("VimResized", {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- Go to last loc when opening a buffer
au("BufReadPost", {
  group = augroup("last_loc"),
  callback = function(ev)
    local exclude = { "gitcommit" }
    local buf = ev.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].myau_last_loc then
      return
    end
    vim.b[buf].myau_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
au("BufWritePre", {
  group = augroup("auto_create_dir"),
  callback = function(ev)
    if ev.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(ev.match) or ev.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

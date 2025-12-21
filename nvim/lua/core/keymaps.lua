local map = vim.keymap.set
local del = vim.keymap.del

-- Remove default keymaps
del("n", "grr")
del("n", "grn")
del("n", "gri")
del("n", "grt")
del({ "n", "v" }, "gra")

-- Better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true })

-- Move
map("", "gs", "^", { desc = "Goto line first non-blank" })
map("", "gh", "0", { desc = "Goto line start" })
map("", "gl", "$", { desc = "Goto line end" })
map("!", "<C-l>", "<right>", { desc = "Move right" })

-- Escape
map("i", "jj", "<esc>", { desc = "Escape" })
map("t", "<esc><esc>", "<C-\\><C-n>", { desc = "Escape" })

-- Add undo break-points
map("i", ",", ",<C-g>u")
map("i", ".", ".<C-g>u")
map("i", ";", ";<C-g>u")

-- Better inputs
map("!", ",,", "_")
map("!", ",.", "&")
map("!", ",/", "*")

-- Completion
map("i", "<tab>", function()
  if tonumber(vim.fn.pumvisible()) == 1 then
    return "<C-y>"
  elseif vim.snippet.active({ direction = 1 }) then
    return "<cmd>lua vim.snippet.jump(1)<cr>"
  else
    return "<tab>"
  end
end, { expr = true })
map("i", "<cr>", function()
  if tonumber(vim.fn.pumvisible()) == 1 then
    return "<C-y>"
  end
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  local before = line:sub(col, col)
  local after = line:sub(col + 1, col + 1)
  local t = {
    ["("] = ")",
    ["["] = "]",
    ["{"] = "}",
  }
  if t[before] and t[before] == after then
    return "<cr><esc>O"
  end
  return "<cr>"
end, { expr = true })

-- Close
map({ "n", "t" }, "<C-q>", "<cmd>close<cr>", { desc = "Close" })

map("n", "q", function()
  if vim.bo.bt ~= "" then
    return "<cmd>close<cr>"
  end
  return "q"
end, { expr = true, desc = "Record macros" })

-- Clear search and stop snippet with <esc>
map({ "i", "n", "s" }, "<esc>", function()
  vim.cmd("noh")
  vim.snippet.stop()
  return "<esc>"
end, { expr = true, desc = "Escape" })

-- Remap undo/redo
map("n", "U", "<C-r>", { desc = "Redo" })
map("n", "<M-u>", "U", { desc = "Undo line" })

map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Commenting
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add comment below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add comment above" })
map("n", "<C-/>", "gccj", { remap = true, desc = "Toggle comment" })
map("n", "<C-_>", "gccj", { remap = true, desc = "Toggle comment" })
map("v", "<C-/>", "gc", { remap = true, desc = "Toggle comment" })
map("v", "<C-_>", "gc", { remap = true, desc = "Toggle comment" })

-- Lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- LSP
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "<leader>cc", vim.lsp.codelens.run, { desc = "Run codelens" })
map("n", "<leader>cl", vim.lsp.codelens.refresh, { desc = "Show codelens" })
map("n", "<leader>cL", "<cmd>checkhealth vim.lsp<cr>", { desc = "LSP info" })
map({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, { desc = "Code action", nowait = true })
map("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename" })

-- Highlights under cursor
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect pos" })
map("n", "<leader>uI", "<cmd>InspectTree<cr>", { desc = "Inspect tree" })

-- Quickfix
map("n", "<leader>xq", vim.cmd.copen, { desc = "Quickfix" })
map("n", "<leader>xl", vim.cmd.lopen, { desc = "Location list" })
map("n", "<leader>xd", vim.diagnostic.setloclist, { desc = "Diagnostics list" })

-- Notification
map("n", "<leader>n", "<cmd>messages<cr>", { desc = "Notification" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-l><CR>",
  { desc = "Redraw / Clear hlsearch / Diff update" }
)

-- Buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to other buffer" })
map("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete buffer and window" })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Windows
map("n", "<leader>w", "<C-w>", { desc = "Windows", remap = true })
map("n", "<leader>wd", "<C-w>c", { desc = "Delete window", remap = true })

-- Tabs
map("n", "<leader><tab>]", "<cmd>tablast<cr>", { desc = "Last tab" })
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close other tabs" })
map("n", "<leader><tab>[", "<cmd>tabfirst<cr>", { desc = "First tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New tab" })
map("n", "]<tab>", "<cmd>tabnext<cr>", { desc = "Next tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close tab" })
map("n", "[<tab>", "<cmd>tabprevious<cr>", { desc = "Previous tab" })

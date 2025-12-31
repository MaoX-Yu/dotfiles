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
map("!", "<C-l>", "<Right>", { desc = "Move right" })

-- Escape
map("i", "jj", "<Esc>", { desc = "Escape" })
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Escape" })

-- Add undo break-points
map("i", ",", ",<C-g>u")
map("i", ".", ".<C-g>u")
map("i", ";", ";<C-g>u")

-- Better inputs
map("!", ",,", "_")
map("!", ",.", "&")
map("!", ",/", "*")

-- Completion
map("i", "<Tab>", function()
  if tonumber(vim.fn.pumvisible()) == 1 then
    return "<C-y>"
  elseif vim.snippet.active({ direction = 1 }) then
    return "<Cmd>lua vim.snippet.jump(1)<CR>"
  else
    return "<Tab>"
  end
end, { expr = true })
map("i", "<CR>", function()
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
    return "<CR><Esc>O"
  end
  return "<CR>"
end, { expr = true })

-- Close
map({ "n", "t" }, "<C-q>", "<Cmd>close<CR>", { desc = "Close" })

map("n", "q", function()
  if vim.bo.bt ~= "" then
    return "<Cmd>close<CR>"
  end
  return "q"
end, { expr = true, desc = "Record macros" })

-- Clear search and stop snippet with <Esc>
map({ "i", "n", "s" }, "<Esc>", function()
  vim.cmd("noh")
  vim.snippet.stop()
  return "<Esc>"
end, { expr = true, desc = "Escape" })

-- Remap undo/redo
map("n", "U", "<C-r>", { desc = "Redo" })
map("n", "<M-u>", "U", { desc = "Undo line" })

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Commenting
map("n", "gco", "o<Esc>Vcx<Esc><Cmd>normal gcc<CR>fxa<bs>", { desc = "Add comment below" })
map("n", "gcO", "O<Esc>Vcx<Esc><Cmd>normal gcc<CR>fxa<bs>", { desc = "Add comment above" })
map("n", "<C-/>", "gccj", { remap = true, desc = "Toggle comment" })
map("n", "<C-_>", "gccj", { remap = true, desc = "Toggle comment" })
map("v", "<C-/>", "gc", { remap = true, desc = "Toggle comment" })
map("v", "<C-_>", "gc", { remap = true, desc = "Toggle comment" })

-- Lazy
map("n", "<Leader>l", "<Cmd>Lazy<CR>", { desc = "Lazy" })

-- LSP
map("n", "<Leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "<Leader>cc", vim.lsp.codelens.run, { desc = "Run codelens" })
map("n", "<Leader>cl", vim.lsp.codelens.refresh, { desc = "Show codelens" })
map("n", "<Leader>cL", "<Cmd>checkhealth vim.lsp<CR>", { desc = "LSP info" })
map({ "n", "v" }, "<Leader>a", vim.lsp.buf.code_action, { desc = "Code action", nowait = true })
map("n", "<Leader>r", vim.lsp.buf.rename, { desc = "Rename" })

-- Highlights under cursor
map("n", "<Leader>ui", vim.show_pos, { desc = "Inspect pos" })
map("n", "<Leader>uI", "<Cmd>InspectTree<CR>", { desc = "Inspect tree" })

-- Quickfix
map("n", "<Leader>xq", vim.cmd.copen, { desc = "Quickfix" })
map("n", "<Leader>xl", vim.cmd.lopen, { desc = "Location list" })
map("n", "<Leader>xd", vim.diagnostic.setloclist, { desc = "Diagnostics list" })

-- Notification
map("n", "<Leader>n", "<Cmd>messages<CR>", { desc = "Notification" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
  "n",
  "<Leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-l><CR>",
  { desc = "Redraw / Clear hlsearch / Diff update" }
)

-- Buffers
map("n", "<S-h>", "<Cmd>bprevious<CR>", { desc = "Prev buffer" })
map("n", "<S-l>", "<Cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<Leader>bb", "<Cmd>e #<CR>", { desc = "Switch to other buffer" })
map("n", "<Leader>bC", "<Cmd>:bd<CR>", { desc = "Close buffer and window" })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<Cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", "<Cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<Cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<Cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- Windows
map("n", "<Leader>w", "<C-w>", { desc = "Windows", remap = true })

-- Tabs
map("n", "<Leader><Tab>]", "<Cmd>tablast<CR>", { desc = "Last tab" })
map("n", "<Leader><Tab>o", "<Cmd>tabonly<CR>", { desc = "Close other tabs" })
map("n", "<Leader><Tab>[", "<Cmd>tabfirst<CR>", { desc = "First tab" })
map("n", "<Leader><Tab><Tab>", "<Cmd>tabnew<CR>", { desc = "New tab" })
map("n", "]<Tab>", "<Cmd>tabnext<CR>", { desc = "Next tab" })
map("n", "<Leader><Tab>c", "<Cmd>tabclose<CR>", { desc = "Close tab" })
map("n", "[<Tab>", "<Cmd>tabprevious<CR>", { desc = "Previous tab" })

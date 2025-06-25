local map = vim.keymap.set
local del = vim.keymap.del

-- Remove default keymaps
del("n", "grr")
del("n", "grn")
del("n", "gri")
del({ "n", "v" }, "gra")

-- Better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move
map({ "n", "o", "x" }, "gh", "^", { desc = "Goto line start" })
map({ "n", "o", "x" }, "gl", "$", { desc = "Goto line end" })
map("!", "<C-l>", "<right>", { desc = "Move right" })

-- Close
map({ "n", "t" }, "<C-q>", "<cmd>close<cr>", { desc = "Close" })

local function super_q()
  if vim.bo.bt ~= "" then
    return "<cmd>close<cr>"
  end
  return "q"
end
map("n", "q", super_q, { expr = true, desc = "Record macros" })

-- Remap redo
map("n", "U", "<C-r>", { desc = "Redo" })

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

-- Buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to other buffer" })
map("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete buffer and window" })

-- Clear search and stop snippet with <esc>
local function super_escape()
  vim.cmd("noh")
  vim.snippet.stop()
  return "<esc>"
end
map({ "i", "n", "s" }, "<esc>", super_escape, { expr = true, desc = "Escape" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / Clear hlsearch / Diff update" }
)

map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

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

-- Quickfix
map("n", "<leader>xq", vim.cmd.copen, { desc = "Quickfix" })
map("n", "<leader>xl", vim.cmd.lopen, { desc = "Location list" })
map("n", "<leader>xd", vim.diagnostic.setloclist, { desc = "Diagnostics list" })

-- LSP
local function diagnostic_goto(count, severity)
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    vim.diagnostic.jump({ count = count, severity = severity })
  end
end
map("n", "]e", diagnostic_goto(1, "ERROR"), { desc = "Next error" })
map("n", "[e", diagnostic_goto(-1, "ERROR"), { desc = "Prev error" })
map("n", "]w", diagnostic_goto(1, "WARN"), { desc = "Next warning" })
map("n", "[w", diagnostic_goto(-1, "WARN"), { desc = "Prev warning" })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "<leader>cc", vim.lsp.codelens.run, { desc = "Run codelens" })
map("n", "<leader>cl", vim.lsp.codelens.refresh, { desc = "Show codelens" })
map("n", "<leader>cL", "<cmd>checkhealth vim.lsp<cr>", { desc = "LSP info" })
map({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename" })

-- Highlights under cursor
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect pos" })
map("n", "<leader>uI", "<cmd>InspectTree<cr>", { desc = "Inspect tree" })

-- Windows
map("n", "<leader>w", "<C-w>", { desc = "Windows", remap = true })
map("n", "<leader>wd", "<C-w>c", { desc = "Delete window", remap = true })

-- Tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last tab" })
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close other tabs" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous tab" })

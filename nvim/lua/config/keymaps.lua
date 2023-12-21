-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local util = require("lazyvim.util")
local comment = require("mini.comment")
local lsp = vim.lsp
local lazyterm = function()
  util.terminal.open(nil, { cwd = util.root.get() })
end

-- Default: <leader> is <space>
local maps = {
  -- stylua: ignore start
  { from = "<C-a>",     to = "ggvG$",          mode = "n",          opts = { desc = "Select all" }                },
  { from = "<C-a>",     to = "<esc>ggvG$",     mode = "i",          opts = { desc = "Select all" }                },
  { from = "gh",        to = "^",              mode = { "n", "v" }, opts = { desc = "Move to the start of line" } },
  { from = "gl",        to = "$",              mode = { "n", "v" }, opts = { desc = "Move to the end of line" }   },
  { from = "Q",         to = "q",              mode = "n",          opts = { desc = "Create macros" }             },
  { from = "q",         to = "@",              mode = "n",          opts = { desc = "Execute macros" }            },
  { from = "<C-q>",     to = "<cmd>q<cr>",     mode = "n",          opts = { desc = "Quit" }                      },
  { from = "<leader>q", to = "<cmd>qa<cr>",    mode = "n",          opts = { desc = "Quit all"}                   },

  -- Terminal
  { from = "<C-t>",     to = lazyterm,         mode = "n",          opts = { desc = "Terminal" }                  },
  { from = "<C-t>",     to = "<cmd>close<cr>", mode = "t",          opts = { desc = "Hide Terminal" }             },
  -- stylua: ignore end

  -- Comment
  {
    from = "<C-/>",
    to = function()
      return comment.operator() .. "_"
    end,
    mode = { "n", "v" },
    opts = { expr = true, desc = "Comment line" },
  },
  {
    from = "<C-_>",
    to = function()
      return comment.operator() .. "_"
    end,
    mode = { "n", "v" },
    opts = { expr = true, desc = "Comment line" },
  },

  -- Rename
  {
    from = "<leader>rn",
    to = function()
      lsp.buf.rename()
    end,
    mode = "n",
    opts = { desc = "Rename Current Symbol" },
  },
}

local unmaps = {
  -- Terminal
  { key = "<C-_>", mode = { "n", "t" } },

  -- Buffer
  { key = "<S-h>", mode = { "n" } },
  { key = "<S-l>", mode = { "n" } },

  -- Quit
  { key = "<leader>qq", mode = { "n" } },
}

for _, unmap in pairs(unmaps) do
  vim.keymap.del(unmap.mode, unmap.key, unmap.opts or {})
end

for _, map in pairs(maps) do
  vim.keymap.set(map.mode, map.from, map.to, map.opts or {})
end

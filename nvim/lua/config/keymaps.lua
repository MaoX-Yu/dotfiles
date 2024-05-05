-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local comment = require("mini.comment")
local lsp = vim.lsp

-- Default: <leader> is <space>
local maps = {
  -- stylua: ignore start
  { from = "<C-a>",     to = "ggvG$",          mode = "n",          opts = { desc = "Select All" }      },
  { from = "<C-a>",     to = "<esc>ggvG$",     mode = "i",          opts = { desc = "Select All" }      },
  { from = "gh",        to = "^",              mode = { "n", "v" }, opts = { desc = "Goto Line Start" } },
  { from = "gl",        to = "$",              mode = { "n", "v" }, opts = { desc = "Goto Line End" }   },
  { from = "Q",         to = "q",              mode = "n",          opts = { desc = "Create Macros" }   },
  { from = "q",         to = "@",              mode = "n",          opts = { desc = "Execute Macros" }  },
  { from = "<C-q>",     to = "<cmd>q<cr>",     mode = "n",          opts = { desc = "Quit" }            },
  { from = "<leader>q", to = "<cmd>qa<cr>",    mode = "n",          opts = { desc = "Quit All"}         },

  -- Terminal
  { from = "<C-q>",     to = "<cmd>close<cr>", mode = "t",          opts = { desc = "Hide Terminal" }   },
  -- stylua: ignore end

  -- Comment
  {
    from = "<C-_>",
    to = function()
      return comment.operator() .. "_"
    end,
    mode = { "n", "v" },
    opts = { expr = true, desc = "Comment Line" },
  },
  {
    from = "<C-/>",
    to = function()
      return comment.operator() .. "_"
    end,
    mode = { "n", "v" },
    opts = { expr = true, desc = "Comment Line" },
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
  { key = "<C-/>", mode = { "n", "t" } },

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

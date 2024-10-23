-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local K = require("utils.keymaps")

-- Default: <leader> is <space>
local maps = {
  -- stylua: ignore start
  { from = "<leader>%",  to = "gg0vG$",         mode = "n",          opts = { desc = "Select All" }                 },
  { from = "<C-a>",      to = "<esc>gg0vG$",    mode = "i",          opts = { desc = "Select All" }                 },
  { from = "gh",         to = "^",              mode = { "n", "x" }, opts = { desc = "Goto Line Start" }            },
  { from = "gl",         to = "$",              mode = { "n", "x" }, opts = { desc = "Goto Line End" }              },
  { from = "Q",          to = "q",              mode = "n",          opts = { desc = "Record Macros" }              },
  { from = "q",          to = K.super_q,        mode = "n",          opts = { expr = true, desc = "Replay Macros" } },
  { from = "U",          to = "<C-r>",          mode = "n",          opts = { desc = "Redo" }                       },
  { from = "<C-q>",      to = "<cmd>q<cr>",     mode = "n",          opts = { desc = "Quit" }                       },
  { from = "<leader>q",  to = "<cmd>qa<cr>",    mode = "n",          opts = { desc = "Quit All"}                    },
  { from = "<esc>",      to = K.super_escape,   mode = { "i", "n" }, opts = { expr = true, desc = "Escape" }        },

  -- Terminal
  { from = "<C-q>",      to = "<cmd>close<cr>", mode = "t",          opts = { desc = "Hide Terminal" }              },

  -- Comment
  { from = "<C-_>",      to = "gccj",           mode = "n",          opts = { remap = true }                        },
  { from = "<C-/>",      to = "gccj",           mode = "n",          opts = { remap = true, desc = "Comment Line" } },
  { from = "<C-_>",      to = "gc",             mode = "v",          opts = { remap = true }                        },
  { from = "<C-/>",      to = "gc",             mode = "v",          opts = { remap = true, desc = "Comment Line" } },

  -- Rename
  { from = "<leader>rn", to = "<leader>cr",     mode = "n",          opts = { remap = true }                        },
  -- stylua: ignore end
}

-- stylua: ignore
local unmaps = {
  -- Terminal
  { key = "<C-_>",      mode = { "n", "t" } },
  { key = "<C-/>",      mode = { "n", "t" } },

  -- Quit
  { key = "<leader>qq", mode = { "n" }      },
}

for _, unmap in pairs(unmaps) do
  vim.keymap.del(unmap.mode, unmap.key, unmap.opts or {})
end

for _, map in pairs(maps) do
  vim.keymap.set(map.mode, map.from, map.to, map.opts or {})
end

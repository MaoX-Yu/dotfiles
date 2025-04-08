-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local K = require("utils.keymaps")

-- Default: <leader> is <space>
local maps = {
  -- stylua: ignore start
  { from = "<leader>%",  to = "ggVG",           mode = "n",          opts = { desc = "Select All" }                 },
  { from = "<C-l>",      to = "<right>",        mode = "!",          opts = { desc = "Move Right" }                 },
  { from = "gh",         to = "^",              mode = { "n", "x" }, opts = { desc = "Goto Line Start" }            },
  { from = "gl",         to = "$",              mode = { "n", "x" }, opts = { desc = "Goto Line End" }              },
  { from = "q",          to = K.super_q,        mode = "n",          opts = { expr = true, desc = "Record Macros" } },
  { from = "U",          to = "<C-r>",          mode = "n",          opts = { desc = "Redo" }                       },
  { from = "<C-q>",      to = "<cmd>close<cr>", mode = { "n", "t" }, opts = { desc = "Close" }                      },
  { from = "<leader>ci", to = K.virt_lines,     mode = "n",          opts = { desc = "Virtual Lines" }              },

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
  -- Buffer
  { key = "<leader>`",  mode = { "n" }      },

  -- Window
  { key = "<leader>-",  mode = { "n" }      },
  { key = "<leader>|",  mode = { "n" }      },

  -- Terminal
  { key = "<C-_>",      mode = { "n", "t" } },
  { key = "<C-/>",      mode = { "n", "t" } },
}

for _, unmap in pairs(unmaps) do
  vim.keymap.del(unmap.mode, unmap.key, unmap.opts or {})
end

for _, map in pairs(maps) do
  vim.keymap.set(map.mode, map.from, map.to, map.opts or {})
end

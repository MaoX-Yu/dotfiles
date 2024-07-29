-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local U = require("utils")

local function super_escape()
  vim.snippet.stop()
  return "<cmd>noh<cr><esc>"
end

-- Default: <leader> is <space>
local maps = {
  -- stylua: ignore start
  { from = "<leader>%",  to = "ggvG$",          mode = "n",          opts = { desc = "Select All" }                 },
  { from = "<C-a>",      to = "<esc>ggvG$",     mode = "i",          opts = { desc = "Select All" }                 },
  { from = "gh",         to = "^",              mode = { "n", "v" }, opts = { desc = "Goto Line Start" }            },
  { from = "gl",         to = "$",              mode = { "n", "v" }, opts = { desc = "Goto Line End" }              },
  { from = "Q",          to = "q",              mode = "n",          opts = { desc = "Create Macros" }              },
  { from = "q",          to = "@",              mode = "n",          opts = { desc = "Execute Macros" }             },
  { from = "U",          to = "<C-r>",          mode = "n",          opts = { desc = "Redo" }                       },
  { from = "<C-q>",      to = "<cmd>q<cr>",     mode = "n",          opts = { desc = "Quit" }                       },
  { from = "<leader>q",  to = "<cmd>qa<cr>",    mode = "n",          opts = { desc = "Quit All"}                    },
  { from = "<esc>",      to = super_escape,     mode = { "i", "n" }, opts = { expr = true, desc = "Escape" }        },

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

  -- Buffer
  { key = "<S-h>",      mode = { "n" }      },
  { key = "<S-l>",      mode = { "n" }      },

  -- Quit
  { key = "<leader>qq", mode = { "n" }      },
}

U.load_keymaps(maps, unmaps)

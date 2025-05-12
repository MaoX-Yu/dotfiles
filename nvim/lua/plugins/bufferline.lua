return {
  {
    "akinsho/bufferline.nvim",
    cond = not vim.g.vscode,
    event = { "BufReadPost", "BufNewFile" },
    opts = function()
      local highlights = require("catppuccin.groups.integrations.bufferline").get()
      return {
        options = {
          always_show_bufferline = false,
          close_command = function(bufnr)
            Snacks.bufdelete(bufnr)
          end,
          diagnostics = "nvim_lsp",
          diagnostics_indicator = function(_, _, diag)
            local icons = {
              Error = " ",
              Warning = " ",
            }
            local ret = (diag.error and icons.Error .. diag.error .. " " or "")
              .. (diag.warning and icons.Warning .. diag.warning or "")
            return vim.trim(ret)
          end,
        },
        highlights = highlights,
      }
    end,
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
    },
  },
}

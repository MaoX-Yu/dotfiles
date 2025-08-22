return {
  {
    "akinsho/bufferline.nvim",
    cond = not vim.g.vscode,
    event = { "BufReadPost", "BufNewFile" },
    opts = function()
      local O = require("catppuccin").options
      local C = require("catppuccin.palettes").get_palette(O.flavour)
      local highlights = require("catppuccin.groups.integrations.bufferline").get_theme({
        custom = {
          all = {
            indicator_visible = { fg = C.mauve },
            indicator_selected = { fg = C.mauve },
          },
        },
      })
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
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },
    },
  },
}

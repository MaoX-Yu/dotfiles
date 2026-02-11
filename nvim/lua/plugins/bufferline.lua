P:add({
  {
    src = "https://github.com/akinsho/bufferline.nvim",
    data = {
      event = { "BufReadPost", "BufNewFile" },
      config = function()
        local O = require("catppuccin").options
        local C = require("catppuccin.palettes").get_palette(O.flavour)
        local highlights = require("catppuccin.special.bufferline").get_theme({
          custom = {
            all = {
              indicator_visible = { fg = C.mauve },
              indicator_selected = { fg = C.mauve },
            },
          },
        })
        require("bufferline").setup({
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
        })

        P.map({
          { "<Leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
          { "<Leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Close non-pinned buffers" },
          { "<Leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Close buffers to the right" },
          { "<Leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Close buffers to the left" },
        })
      end,
    },
  },
})

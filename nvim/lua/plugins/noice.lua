-- TODO: remove?
return {
  {
    "folke/noice.nvim",
    enabled = false,
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {
      lsp = {
        progress = {
          enabled = false,
        },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
      },
    },
  },
}

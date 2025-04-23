return {
  {
    "folke/noice.nvim",
    cond = not vim.g.vscode,
    event = "VeryLazy",
    opts = {
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
      lsp = {
        progress = {
          enabled = false,
        },
      },
      views = {
        split = {
          size = "35%",
        },
      },
    },
  },
}

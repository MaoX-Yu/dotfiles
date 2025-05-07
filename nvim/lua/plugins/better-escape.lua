return {
  {
    "max397574/better-escape.nvim",
    cond = not vim.g.vscode,
    opts = {
      default_mappings = false,
      mappings = {
        i = {
          j = {
            j = "<Esc>",
          },
        },
        t = {
          ["<esc>"] = {
            ["<esc>"] = "<C-\\><C-n>",
          },
        },
      },
    },
  },
}

return {
  {
    "max397574/better-escape.nvim",
    cond = not vim.g.vscode,
    event = "VeryLazy",
    opts = {
      mappings = {
        t = {
          j = {
            k = false,
          },
          ["<esc>"] = {
            ["<esc>"] = "<C-\\><C-n>",
          },
        },
      },
    },
  },
}

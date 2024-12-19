return {
  {
    "max397574/better-escape.nvim",
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

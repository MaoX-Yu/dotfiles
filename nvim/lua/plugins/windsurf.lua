return {
  {
    "Exafunction/windsurf.nvim",
    cond = not vim.g.vscode,
    event = "InsertEnter",
    cmd = "Codeium",
    opts = {},
    config = function(_, opts)
      require("codeium").setup(opts)
    end,
  },
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        default = { "codeium" },
        providers = {
          codeium = {
            name = "Codeium",
            module = "codeium.blink",
            async = true,
            score_offset = 100,
          },
        },
      },
    },
  },
}

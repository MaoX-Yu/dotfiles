return {
  {
    "saghen/blink.cmp",
    version = "*",
    lazy = false,
    dependencies = "rafamadriz/friendly-snippets",
    opts_extend = { "sources.default" },
    opts = {
      keymap = { preset = "default" },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        cmdline = {},
      },
    },
  },
  {
    "saghen/blink.compat",
    version = "*",
    lazy = true,
    opts = {},
  },
}

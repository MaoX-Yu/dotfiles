return {
  {
    "saghen/blink.cmp",
    version = "*",
    event = "InsertEnter",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts_extend = { "sources.default" },
    opts = {
      keymap = {
        preset = "enter",
      },
      cmdline = {
        keymap = {
          ["<CR>"] = { "accept_and_enter", "fallback" },
        },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
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

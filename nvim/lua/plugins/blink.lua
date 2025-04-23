return {
  {
    "saghen/blink.cmp",
    cond = not vim.g.vscode,
    version = "*",
    event = "InsertEnter",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts_extend = { "sources.default" },
    opts = {
      keymap = {
        preset = "super-tab",
        ["<CR>"] = { "accept", "fallback" },
      },
      cmdline = {
        enabled = false,
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

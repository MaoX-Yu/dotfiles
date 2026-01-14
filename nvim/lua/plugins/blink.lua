return {
  {
    "saghen/blink.cmp",
    cond = not vim.g.vscode,
    event = "InsertEnter",
    version = "*",
    opts_extend = { "sources.default" },
    opts = {
      keymap = {
        preset = "super-tab",
        ["<CR>"] = { "select_and_accept", "fallback" },
      },
      completion = {
        accept = {
          auto_brackets = { enabled = true },
        },
        menu = { border = "none" },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
        },
      },
      cmdline = { enabled = false },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    },
  },
}

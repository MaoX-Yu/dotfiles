P:add({
  {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range("*"),
    data = {
      event = { "InsertEnter" },
      config = function()
        require("blink.cmp").setup({
          keymap = {
            preset = "default",
            ["<CR>"] = { "select_and_accept", "fallback" },
            ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
            ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
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
            per_filetype = {
              codecompanion = { "codecompanion" },
            },
          },
        })
      end,
    },
  },
})

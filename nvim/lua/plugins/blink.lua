local utils = require("utils") ---@as MaoUtils
local lazy = utils.pack.lazy

vim.pack.add({
  {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range("*"),
    data = {
      event = { "InsertEnter" },
      config = function()
        ---@diagnostic disable: missing-fields
        require("blink.cmp").setup({
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
        } --[[@as blink.cmp.Config]])
      end,
    },
  },
}, {
  load = lazy,
})

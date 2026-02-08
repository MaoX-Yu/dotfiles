local utils = require("utils") ---@as MaoUtils
local lazy = utils.pack.lazy
local map = utils.pack.map

vim.pack.add({
  {
    src = "https://github.com/mason-org/mason.nvim",
    data = {
      cmd = {
        "Mason",
        "MasonUpdate",
        "MasonLog",
      },
      event = { "BufReadPre", "BufNewFile" },
      config = function()
        ---@diagnostic disable-next-line: missing-fields
        require("mason").setup({
          ui = {
            icons = {
              package_installed = "✓",
              package_uninstalled = "✗",
              package_pending = "⟳",
            },
          },
        } --[[@as MasonSettings]])

        map({
          { "<Leader>cm", "<Cmd>Mason<CR>", desc = "Mason" },
        })
      end,
    },
  },
}, {
  load = lazy,
})

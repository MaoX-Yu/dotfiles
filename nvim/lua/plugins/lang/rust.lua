if vim.env.NVIM_LSP_DISABLED and not vim.env.NVIM_LSP_RUST then
  return {}
end

local utils = require("utils") ---@as MaoUtils
local lazy = utils.pack.lazy

vim.pack.add({
  "https://github.com/mrcjkb/rustaceanvim",
  {
    src = "https://github.com/Saecki/crates.nvim",
    data = {
      event = { "BufRead Cargo.toml" },
      config = function()
        require("crates").setup({
          completion = {
            crates = {
              enabled = true,
            },
          },
          lsp = {
            enabled = true,
            actions = true,
            completion = true,
            hover = true,
          },
        })
      end,
    },
  },
}, {
  load = lazy,
})

require("nvim-treesitter").install({ "rust", "ron" })

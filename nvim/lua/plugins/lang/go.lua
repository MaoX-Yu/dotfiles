if vim.env.NVIM_LSP_DISABLED and not vim.env.NVIM_LSP_GO then
  return
end

local utils = require("utils") ---@as MaoUtils
local lazy = utils.pack.lazy

vim.pack.add({
  {
    src = "https://github.com/leoluz/nvim-dap-go",
    data = {
      ft = { "go" },
      config = function()
        require("nvim-dap-go").setup({})
      end,
    },
  },
}, {
  load = lazy,
})

require("nvim-treesitter").install({ "go", "gomod", "gowork", "gosum" })

if vim.env.NVIM_LSP_DISABLED and not vim.env.NVIM_LSP_PYTHON then
  return {}
end

local utils = require("utils") ---@as MaoUtils
local lazy = utils.pack.lazy

vim.pack.add({
  {
    src = "https://github.com/mfussenegger/nvim-dap-python",
    data = {
      ft = { "python" },
      config = function()
        require("dap-python").setup("debugpy-adapter")
      end,
    },
  },
}, {
  load = lazy,
})

require("nvim-treesitter").install({ "python" })

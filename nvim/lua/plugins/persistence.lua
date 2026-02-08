local utils = require("utils") ---@as MaoUtils
local lazy = utils.pack.lazy

vim.pack.add({
  {
    src = "https://github.com/folke/persistence.nvim",
    data = {
      config = function()
        require("persistence").setup({})
      end,
    },
  },
}, {
  load = lazy,
})

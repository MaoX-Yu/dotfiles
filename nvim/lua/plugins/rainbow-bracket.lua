local utils = require("utils") ---@as MaoUtils
local lazy = utils.pack.lazy

vim.pack.add({
  {
    src = "https://github.com/HiPhish/rainbow-delimiters.nvim",
    data = {
      event = { "BufReadPost", "BufNewFile" },
      config = function()
        require("rainbow-delimiters.setup").setup({})
      end,
    },
  },
}, {
  load = lazy,
})

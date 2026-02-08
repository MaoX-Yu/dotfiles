local utils = require("utils") ---@as MaoUtils
local lazy = utils.pack.lazy

vim.pack.add({
  {
    src = "https://github.com/nmac427/guess-indent.nvim",
    data = {
      event = { "BufReadPost", "BufNewFile" },
      config = function()
        require("guess-indent").setup({})
      end,
    },
  },
}, {
  load = lazy,
})

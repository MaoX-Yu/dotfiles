local utils = require("utils") ---@as MaoUtils
local lazy = utils.pack.lazy

vim.pack.add({
  {
    src = "https://github.com/mfussenegger/nvim-lint",
    data = {
      config = function()
        require("lint").linters_by_ft = {
          markdown = { "markdownlint-cli2" },
        }
        vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
          callback = function()
            require("lint").try_lint()
          end,
        })
      end,
    },
  },
}, {
  load = lazy,
})

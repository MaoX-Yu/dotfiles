P:add({
  {
    src = "https://github.com/mfussenegger/nvim-lint",
    data = {
      config = function()
        require("lint").linters_by_ft = {
          vue = { "eslint" },
          javascript = { "eslint" },
          typescript = { "eslint" },
        }
        vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
          callback = function()
            require("lint").try_lint()
          end,
        })
      end,
    },
  },
})

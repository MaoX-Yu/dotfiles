P:add({
  {
    src = "https://github.com/leoluz/nvim-dap-go",
    data = {
      ft = { "go" },
      config = function()
        require("nvim-dap-go").setup({})
      end,
    },
  },
})

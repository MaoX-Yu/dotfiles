P:add({
  {
    src = "https://github.com/folke/persistence.nvim",
    data = {
      config = function()
        require("persistence").setup({})
      end,
    },
  },
})

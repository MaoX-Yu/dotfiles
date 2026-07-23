P:add({
  {
    src = "https://github.com/nmac427/guess-indent.nvim",
    data = {
      config = function()
        require("guess-indent").setup({})
      end,
    },
  },
})

P:add({
  {
    src = "https://github.com/nmac427/guess-indent.nvim",
    data = {
      event = { "BufReadPost", "BufNewFile" },
      config = function()
        require("guess-indent").setup({})
      end,
    },
  },
})

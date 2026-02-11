P:add({
  {
    src = "https://github.com/HiPhish/rainbow-delimiters.nvim",
    data = {
      event = { "BufReadPost", "BufNewFile" },
      config = function()
        require("rainbow-delimiters.setup").setup({})
      end,
    },
  },
})

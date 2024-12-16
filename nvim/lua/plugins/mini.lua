return {
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      require("mini.ai").setup({})
      require("mini.hipatterns").setup({})
      require("mini.pairs").setup({})
      require("mini.splitjoin").setup({})
    end,
  },
}

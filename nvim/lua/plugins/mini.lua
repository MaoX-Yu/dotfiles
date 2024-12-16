return {
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      require("mini.ai").setup({})
      require("mini.hipatterns").setup({})
      require("mini.icons").setup({})
      require("mini.pairs").setup({})
      require("mini.splitjoin").setup({})
      require("mini.surround").setup({})

      MiniIcons.mock_nvim_web_devicons()
    end,
  },
}

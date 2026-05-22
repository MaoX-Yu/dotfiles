P:add({
  {
    src = "https://www.github.com/olimorris/codecompanion.nvim",
    version = vim.version.range("^19.0.0"),
    data = {
      config = function()
        require("codecompanion").setup({
          interactions = {
            chat = {
              adapter = "deepseek",
              model = "deepseek-v4-pro"
            },
          },
        })
      end,
    },
  },
})

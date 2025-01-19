return {
  {
    "folke/noice.nvim",
    optional = true,
    init = function()
      vim.o.cmdheight = 0
    end,
    opts = {
      lsp = {
        progress = {
          enabled = false,
        },
      },
    },
  },
}

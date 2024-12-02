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
    -- stylua: ignore
    keys = {
      { "<leader>sn",  false },
      { "<leader>snl", false },
      { "<leader>snh", false },
      { "<leader>sna", false },
      { "<leader>snd", false },
      { "<leader>snt", false },
    },
  },
}

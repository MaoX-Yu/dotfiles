return {
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    event = { "BufReadPost", "BufNewFile", "BufWritePost" },
    opts = function(_, opts)
      return require("plugins.configs.lualine").opts(opts)
    end,
  },
}

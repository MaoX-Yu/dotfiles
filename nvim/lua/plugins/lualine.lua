return {
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function(_, opts)
      return require("plugins.configs.lualine").opts(opts)
    end,
  },
}

return {
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function()
      return require("plugins.configs.lualine").opts()
    end,
  },
}

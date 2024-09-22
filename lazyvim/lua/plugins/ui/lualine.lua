return {
  {
    "nvim-lualine/lualine.nvim",
    enabled = false,
    optional = true,
    event = { "BufReadPost", "BufNewFile", "BufWritePost" },
    opts = function(_, opts)
      return require("plugins.configs.lualine").opts(opts)
    end,
  },
}

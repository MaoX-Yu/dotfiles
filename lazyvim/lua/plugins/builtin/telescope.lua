return {
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = function(_, opts)
      opts.defaults.layout_config = {
        horizontal = {
          preview_width = 0.55,
        },
      }
      return opts
    end,
  },
}

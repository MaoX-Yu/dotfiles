return {
  {
    "folke/snacks.nvim",
    optional = true,
    opts = {
      indent = {
        chunk = {
          enabled = true,
          hl = {
            "RainbowRed",
            "RainbowYellow",
            "RainbowBlue",
            "RainbowOrange",
            "RainbowGreen",
            "RainbowViolet",
            "RainbowCyan",
          },
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>qp", false },
      { "<leader>sp", function() Snacks.picker.projects() end, desc = "Projects" },
    },
  },
}

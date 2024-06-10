return {
  {
    "gorbit99/codewindow.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      {
        "<leader>um",
        function()
          require("codewindow").toggle_minimap()
        end,
        desc = "Toggle Minimap",
      },
    },
    opts = {
      minimap_width = 20,
      width_multiplier = 2,
      screen_bounds = "background",
      window_border = "none",
      relative = "win",
      exclude_filetypes = {
        "dashboard",
        "neo-tree",
        "lazy",
        "lazyterm",
        "mason",
        "help",
        "checkhealth",
        "lspinfo",
        "noice",
        "Trouble",
      },
    },
  },
}

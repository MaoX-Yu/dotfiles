return {
  {
    "LazyVim/LazyVim",
    version = false,
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    "folke/tokyonight.nvim",
    enabled = false,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    optional = true,
    opts = {
      flavour = "macchiato",
      integrations = {
        blink_cmp = true,
        dropbar = {
          enabled = true,
          color_mode = false, -- enable color for kind's texts, not just kind's icons
        },
        fzf = true,
        indent_blankline = {
          enabled = true,
          colored_indent_levels = true,
        },
        lsp_saga = true,
        telescope = {
          enabled = true,
        },
      },
      styles = {
        conditionals = {},
        functions = { "italic" },
        properties = { "italic" },
        types = { "italic" },
      },
      custom_highlights = function(C)
        return require("plugins.configs.catppuccin").highlights(C)
      end,
    },
  },
}

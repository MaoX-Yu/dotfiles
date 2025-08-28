return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "macchiato",
      styles = {
        conditionals = {},
        functions = { "italic" },
        properties = { "italic" },
        types = { "italic" },
      },
      integrations = {
        avante = true,
        blink_cmp = true,
        indent_blankline = {
          enabled = true,
          colored_indent_levels = true,
        },
        mason = true,
        noice = true,
        overseer = true,
        snacks = {
          enabled = true,
          indent_scope_color = "",
        },
        which_key = false,
      },
      custom_highlights = function(C)
        return {
          FloatBorder = { fg = C.mauve, bg = C.mantle },
          PmenuExtra = { fg = C.mauve },
          PmenuExtraSel = { fg = C.mauve, bg = C.surface0, style = { "bold" } },
          PmenuMatch = { fg = C.pink, style = { "bold" } },
          PmenuMatchSel = { fg = C.pink, style = { "bold" } },

          -- Which-key
          WhichKey = { fg = C.mauve, style = { "italic" } },
          WhichKeyDesc = { fg = C.green },
          WhichKeySeparator = { fg = C.mauve },
          WhichKeyTitle = { fg = C.mauve, bg = C.mantle },

          -- Snacks
          SnacksDashboardDesc = { fg = C.mauve },
          SnacksDashboardFooter = { fg = C.green },
          SnacksDashboardHeader = { fg = C.mauve },
          SnacksDashboardIcon = { fg = C.peach },
          SnacksDashboardKey = { fg = C.yellow },
          SnacksInputBorder = { fg = C.mauve, style = { "italic" } },
          SnacksInputIcon = { fg = C.mauve, style = { "italic" } },
          SnacksInputTitle = { fg = C.mauve, style = { "italic" } },
          SnacksNotifierHistory = { link = "NormalFloat" },
          SnacksPickerMatch = { fg = C.pink },

          -- Overseer
          OverseerTask = { fg = C.mauve },
        }
      end,
    },
  },
}

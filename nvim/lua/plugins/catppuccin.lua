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

          -- Which-key
          WhichKey = { fg = C.mauve, style = { "italic" } },
          WhichKeyDesc = { fg = C.green },
          WhichKeyTitle = { fg = C.mauve, bg = C.mantle },
          WhichKeySeparator = { fg = C.mauve },

          -- Snacks
          SnacksDashboardDesc = { fg = C.mauve },
          SnacksDashboardHeader = { fg = C.mauve },
          SnacksDashboardIcon = { fg = C.peach },
          SnacksDashboardKey = { fg = C.green },
          SnacksInputBorder = { fg = C.mauve, style = { "italic" } },
          SnacksInputIcon = { fg = C.mauve, style = { "italic" } },
          SnacksInputTitle = { fg = C.mauve, style = { "italic" } },
          SnacksPickerMatch = { fg = C.pink },

          -- Blink.cmp
          BlinkCmpMenuBorder = { link = "FloatBorder" },
          BlinkCmpKind = { fg = C.overlay2 },
          BlinkCmpSource = { fg = C.overlay2 },
          BlinkCmpLabelDetail = { link = "BlinkCmpSource" },
          BlinkCmpLabelDescription = { link = "BlinkCmpSource" },
          BlinkCmpKindCodeium = { link = "BlinkCmpKindCopilot" },
          BlinkCmpKindAvante = { link = "BlinkCmpKindCopilot" },

          -- Overseer
          OverseerTask = { fg = C.mauve },
        }
      end,
    },
  },
}

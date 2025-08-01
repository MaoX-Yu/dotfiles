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
        which_key = true,
      },
      custom_highlights = function(C)
        return {
          -- which-key
          WhichKeyBorder = { fg = C.blue, bg = C.mantle },
          WhichKeyTitle = { fg = C.blue, bg = C.mantle },

          -- snacks
          SnacksInputIcon = { fg = C.blue, style = { "italic" } },
          SnacksInputTitle = { fg = C.blue, style = { "italic" } },
          SnacksInputBorder = { fg = C.blue, style = { "italic" } },
          SnacksPicker = { link = "Normal" },

          -- mini
          MiniTablineCurrent = { fg = C.mauve, bg = C.base, sp = C.mauve, style = { "bold", "italic", "underline" } },
          MiniTablineModifiedCurrent = { fg = C.yellow, bg = C.base, style = { "bold", "italic", "underline" } },
          MiniTablineModifiedHidden = { fg = C.yellow, bg = C.none },
          MiniTablineModifiedVisible = { fg = C.yellow, bg = C.none },

          -- flash
          FlashLabel = { fg = C.base, bg = C.green },

          -- nvim-cmp
          CmpItemKindCodeium = { fg = C.teal },

          -- blink.cmp
          BlinkCmpKind = { fg = C.overlay2 },
          BlinkCmpSource = { fg = C.overlay2 },
          BlinkCmpLabelDetail = { link = "BlinkCmpSource" },
          BlinkCmpLabelDescription = { link = "BlinkCmpSource" },
          BlinkCmpKindCodeium = { link = "BlinkCmpKindCopilot" },
          BlinkCmpKindAvante = { link = "BlinkCmpKindCopilot" },

          -- fzf-lua
          FzfLuaNormal = { link = "Normal" },
        }
      end,
    },
  },
}

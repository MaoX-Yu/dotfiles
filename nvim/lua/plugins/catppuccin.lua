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
        indent_blankline = {
          enabled = true,
          colored_indent_levels = true,
        },
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
          FlashLabel = { fg = C.base, bg = C.red },

          -- nvim-cmp
          CmpItemMenu = { fg = C.mauve },
          CmpItemKindCodeium = { fg = C.teal },

          -- blink.cmp
          BlinkCmpKind = { fg = C.overlay2 },
          BlinkCmpSource = { fg = C.overlay2 },
          BlinkCmpLabelDetail = { link = "BlinkCmpSource" },
          BlinkCmpLabelDescription = { link = "BlinkCmpSource" },
          BlinkCmpKindCodeium = { link = "CmpItemKindCodeium" },
          BlinkCmpKindAvante = { link = "CmpItemKindCodeium" },

          -- fzf-lua
          FzfLuaNormal = { link = "Normal" },

          -- statusline
          StatuslineNormal = { bg = C.lavender, fg = C.mantle, style = { "bold" } },
          StatuslineInsert = { bg = C.green, fg = C.base, style = { "bold" } },
          StatuslineTerminal = { bg = C.green, fg = C.base, style = { "bold" } },
          StatuslineCommand = { bg = C.peach, fg = C.base, style = { "bold" } },
          StatuslineVisual = { bg = C.flamingo, fg = C.base, style = { "bold" } },
          StatuslineReplace = { bg = C.maroon, fg = C.base, style = { "bold" } },
          StatuslineInactive = { bg = C.mantle, fg = C.lavender },
          StatuslineHistoryCommand = { bg = C.mantle, fg = C.mauve },
          StatuslineLazy = { bg = C.mantle, fg = C.pink },
          StatuslineDebug = { bg = C.mantle, fg = C.red },
          StatuslineOverseerRUNNING = { bg = C.mantle, fg = C.yellow },
          StatuslineOverseerSUCCESS = { bg = C.mantle, fg = C.green },
          StatuslineOverseerCANCELED = { bg = C.mantle, fg = C.overlay2 },
          StatuslineOverseerFAILURE = { bg = C.mantle, fg = C.red },
        }
      end,
    },
  },
}

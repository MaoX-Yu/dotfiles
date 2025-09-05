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

          -- statusline
          StatusLineNormal = { bg = C.mauve, fg = C.mantle, style = { "bold" } },
          StatusLineNormalB = { bg = C.surface0, fg = C.mauve },
          StatusLineInsert = { bg = C.green, fg = C.base, style = { "bold" } },
          StatusLineInsertB = { bg = C.surface0, fg = C.green },
          StatusLineTerminal = { bg = C.green, fg = C.base, style = { "bold" } },
          StatusLineTerminalB = { bg = C.surface0, fg = C.green },
          StatusLineCommand = { bg = C.peach, fg = C.base, style = { "bold" } },
          StatusLineCommandB = { bg = C.surface0, fg = C.peach },
          StatusLineVisual = { bg = C.lavender, fg = C.base, style = { "bold" } },
          StatusLineVisualB = { bg = C.surface0, fg = C.lavender },
          StatusLineReplace = { bg = C.maroon, fg = C.base, style = { "bold" } },
          StatusLineReplaceB = { bg = C.surface0, fg = C.maroon },
          StatusLineInactive = { bg = C.mantle, fg = C.lavender },
          StatusLineAdd = { bg = C.surface0, fg = C.green },
          StatusLineChange = { bg = C.surface0, fg = C.yellow },
          StatusLineRemove = { bg = C.surface0, fg = C.red },
          StatusLineError = { bg = C.surface0, fg = C.red },
          StatusLineWarn = { bg = C.surface0, fg = C.yellow },
          StatusLineInfo = { bg = C.surface0, fg = C.sky },
          StatusLineHint = { bg = C.surface0, fg = C.teal },
          StatusLineHistoryCommand = { bg = C.mantle, fg = C.mauve },
          StatusLineLazy = { bg = C.mantle, fg = C.pink },
          StatusLineDebug = { bg = C.mantle, fg = C.red },
          StatusLineOverseerRUNNING = { bg = C.mantle, fg = C.yellow },
          StatusLineOverseerSUCCESS = { bg = C.mantle, fg = C.green },
          StatusLineOverseerCANCELED = { bg = C.mantle, fg = C.overlay2 },
          StatusLineOverseerFAILURE = { bg = C.mantle, fg = C.red },
        }
      end,
    },
  },
}

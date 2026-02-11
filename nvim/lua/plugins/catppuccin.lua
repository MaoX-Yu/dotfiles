P:add({
  {
    src = "https://github.com/catppuccin/nvim",
    name = "catppuccin",
    data = {
      config = function()
        require("catppuccin").setup({
          flavour = "auto",
          background = {
            light = "latte",
            dark = "mocha",
          },
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
              FloatBorder = { fg = C.lavender, bg = C.mantle },
              PmenuBorder = { link = "FloatBorder" },
              PmenuExtra = { fg = C.mauve },
              PmenuExtraSel = { fg = C.mauve, bg = C.surface0, style = { "bold" } },
              PmenuMatch = { fg = C.pink, style = { "bold" } },
              PmenuMatchSel = { fg = C.pink, style = { "bold" } },

              -- Which-key
              WhichKey = { fg = C.lavender, style = { "italic" } },
              WhichKeyDesc = { fg = C.text },
              WhichKeyGroup = { fg = C.lavender },
              WhichKeySeparator = { fg = C.lavender },
              WhichKeyTitle = { fg = C.lavender, bg = C.mantle },

              -- Snacks
              SnacksDashboardDesc = { fg = C.green },
              SnacksDashboardFooter = { fg = C.green },
              SnacksDashboardHeader = { fg = C.mauve },
              SnacksDashboardIcon = { fg = C.peach },
              SnacksDashboardKey = { fg = C.yellow },
              SnacksDashboardTitle = { fg = C.mauve },
              SnacksInputBorder = { fg = C.lavender, style = { "italic" } },
              SnacksInputIcon = { fg = C.lavender, style = { "italic" } },
              SnacksInputTitle = { fg = C.lavender, style = { "italic" } },
              SnacksNotifierHistory = { link = "NormalFloat" },
              SnacksPickerMatch = { fg = C.pink },

              -- Overseer
              OverseerTask = { fg = C.lavender },

              -- StatusLine
              StatusLineAdd = { fg = C.green },
              StatusLineChange = { fg = C.yellow },
              StatusLineRemove = { fg = C.red },
              StatusLineError = { fg = C.red },
              StatusLineWarn = { fg = C.yellow },
              StatusLineInfo = { fg = C.sky },
              StatusLineHint = { fg = C.teal },
              StatusLineShowcmd = { fg = C.mauve },
              StatusLineLazy = { fg = C.pink },
              StatusLineDebug = { fg = C.red },
              StatusLineOverseerRUNNING = { fg = C.yellow },
              StatusLineOverseerSUCCESS = { fg = C.green },
              StatusLineOverseerCANCELED = { fg = C.overlay2 },
              StatusLineOverseerFAILURE = { fg = C.red },
            }
          end,
        } --[[@as CatppuccinOptions]])

        vim.cmd.colorscheme("catppuccin")
      end,
    },
  },
})

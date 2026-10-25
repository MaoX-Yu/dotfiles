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
          auto_integrations = true,
          integrations = {
            blink_cmp = true,
            indent_blankline = {
              enabled = true,
              colored_indent_levels = true,
            },
            mason = true,
            overseer = true,
            telescope = false,
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

              -- Local editor UI
              MaoInputBorder = { fg = C.lavender, style = { "italic" } },
              MaoInputIcon = { fg = C.lavender, style = { "italic" } },
              MaoInputTitle = { fg = C.lavender, style = { "italic" } },

              -- Telescope
              TelescopeBorder = { link = "FloatBorder" },
              TelescopeMatching = { fg = C.pink },
              TelescopeMultiSelection = { fg = C.yellow },
              TelescopeNormal = { link = "NormalFloat" },
              TelescopePreviewNormal = { link = "TelescopeNormal" },
              TelescopePromptNormal = { link = "TelescopeNormal" },
              TelescopePromptPrefix = { fg = C.flamingo },
              TelescopeResultsNormal = { link = "TelescopeNormal" },
              TelescopeSelection = { bg = C.surface0, style = { "bold" } },
              TelescopeSelectionCaret = { fg = C.flamingo, bg = C.surface0 },
              TelescopeTitle = { link = "FloatTitle" },

              -- Overseer
              OverseerTask = { fg = C.lavender },
            }
          end,
        })

        vim.cmd.colorscheme("catppuccin-nvim")
      end,
    },
  },
})

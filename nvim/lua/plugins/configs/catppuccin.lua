local M = {}

M.highlights = function(C)
  return {
    PmenuSbar = { bg = C.mantle },
    Visual = { bg = C.surface1, reverse = true, style = { "bold" } },
    VisualNOS = { bg = C.surface1, reverse = true, style = { "bold" } },
    VisualFallback = { bg = C.surface1, style = { "bold" } },

    -- lazy.nvim
    LazyButtonActive = { link = "VisualFallback" },

    -- lspsaga
    SagaBorder = { fg = C.mantle, bg = C.mantle },
    SagaNormal = { bg = C.mantle },
    SagaBeacon = { bg = C.mantle },

    -- which-key
    WhichKeyBorder = { fg = C.blue, bg = C.mantle },
    WhichKeyTitle = { fg = C.blue, bg = C.mantle },

    -- scrollview
    ScrollView = { bg = C.surface1 },

    -- nvim-cmp
    CmpItemAbbr = { fg = C.text },
    CmpItemMenu = { fg = C.mauve },
    CmpItemSel = { fg = C.mantle, bg = C.green, style = { "bold" } },
    CmpItemAbbrMatch = { fg = C.blue, style = { "bold" } },
    CmpItemAbbrMatchFuzzy = { fg = C.blue, style = { "bold" } },
    CmpItemKindSnippet = { fg = C.mantle, bg = C.mauve },
    CmpItemKindKeyword = { fg = C.mantle, bg = C.red },
    CmpItemKindText = { fg = C.mantle, bg = C.teal },
    CmpItemKindMethod = { fg = C.mantle, bg = C.blue },
    CmpItemKindConstructor = { fg = C.mantle, bg = C.blue },
    CmpItemKindFunction = { fg = C.mantle, bg = C.blue },
    CmpItemKindFolder = { fg = C.mantle, bg = C.blue },
    CmpItemKindModule = { fg = C.mantle, bg = C.blue },
    CmpItemKindConstant = { fg = C.mantle, bg = C.peach },
    CmpItemKindField = { fg = C.mantle, bg = C.green },
    CmpItemKindProperty = { fg = C.mantle, bg = C.green },
    CmpItemKindEnum = { fg = C.mantle, bg = C.green },
    CmpItemKindUnit = { fg = C.mantle, bg = C.green },
    CmpItemKindClass = { fg = C.mantle, bg = C.yellow },
    CmpItemKindVariable = { fg = C.mantle, bg = C.flamingo },
    CmpItemKindFile = { fg = C.mantle, bg = C.blue },
    CmpItemKindInterface = { fg = C.mantle, bg = C.yellow },
    CmpItemKindColor = { fg = C.mantle, bg = C.red },
    CmpItemKindReference = { fg = C.mantle, bg = C.red },
    CmpItemKindEnumMember = { fg = C.mantle, bg = C.red },
    CmpItemKindStruct = { fg = C.mantle, bg = C.blue },
    CmpItemKindValue = { fg = C.mantle, bg = C.peach },
    CmpItemKindEvent = { fg = C.mantle, bg = C.blue },
    CmpItemKindOperator = { fg = C.mantle, bg = C.blue },
    CmpItemKindTypeParameter = { fg = C.mantle, bg = C.blue },
    CmpItemKindCopilot = { fg = C.mantle, bg = C.teal },
    CmpItemKindCodeium = { fg = C.mantle, bg = C.teal },
    CmpItemKindFittenCode = { fg = C.mantle, bg = C.teal },

    -- dropbar
    DropBarIconKindClass = { fg = C.yellow },
    DropBarIconKindConstructor = { fg = C.blue },
    DropBarIconKindDeclaration = { fg = C.mauve },
    DropBarIconKindEnum = { fg = C.green },
    DropBarIconKindEnumMember = { fg = C.red },
    DropBarIconKindEvent = { fg = C.blue },
    DropBarIconKindField = { fg = C.green },
    DropBarIconKindIdentifier = { fg = C.flamingo },
    DropBarIconKindInterface = { fg = C.yellow },
    DropBarIconKindMethod = { fg = C.blue },
    DropBarIconKindModule = { fg = C.blue },
    DropBarIconKindPackage = { fg = C.blue },
    DropBarIconKindProperty = { fg = C.green },
    DropBarIconKindReference = { fg = C.red },
    DropBarIconKindStruct = { fg = C.blue },
    DropBarIconKindType = { fg = C.yellow },
    DropBarIconKindTypeParameter = { fg = C.blue },
    DropBarIconKindUnit = { fg = C.green },
    DropBarIconKindVariable = { fg = C.flamingo },
    DropBarHover = { link = "VisualFallback" },
    DropBarCurrentContext = { link = "VisualFallback" },
    DropBarMenuHoverEntry = { link = "VisualFallback" },

    -- codewindow
    CodewindowBackground = { bg = C.mantle },

    -- fzf-lua
    FzfLuaNormal = { link = "Normal" },
  }
end

return M

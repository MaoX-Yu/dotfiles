local M = {}

M.highlights = function(C)
  return {
    Visual = { bg = C.surface1, reverse = true, style = { "bold" } },
    VisualNOS = { bg = C.surface1, reverse = true, style = { "bold" } },
    VisualFallback = { bg = C.surface1, style = { "bold" } },

    -- lazy.nvim
    LazyButtonActive = { link = "VisualFallback" },

    -- which-key
    WhichKeyBorder = { fg = C.blue, bg = C.mantle },
    WhichKeyTitle = { fg = C.blue, bg = C.mantle },

    -- flash
    FlashLabel = { fg = C.base, bg = C.red },

    -- nvim-cmp
    CmpItemMenu = { fg = C.mauve },
    CmpItemKindCodeium = { fg = C.teal },
    CmpItemKindFittenCode = { fg = C.teal },

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
end

return M

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
    CmpItemMenu = { fg = C.mauve },
    CmpItemHover = { fg = C.mantle, bg = C.green, style = { "bold" } },
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

    -- codewindow
    CodewindowBackground = { bg = C.mantle },

    -- fzf-lua
    FzfLuaNormal = { link = "Normal" },

    -- leap
    LeapBackdrop = { fg = C.overlay0 },

    -- statusline
    StatuslineNormal = { bg = C.blue, fg = C.mantle, style = { "bold" } },
    StatuslineInsert = { bg = C.green, fg = C.base, style = { "bold" } },
    StatuslineTerminal = { bg = C.green, fg = C.base, style = { "bold" } },
    StatuslineCommand = { bg = C.peach, fg = C.base, style = { "bold" } },
    StatuslineVisual = { bg = C.mauve, fg = C.base, style = { "bold" } },
    StatuslineReplace = { bg = C.red, fg = C.base, style = { "bold" } },
    StatuslineInactive = { bg = C.mantle, fg = C.blue },
    StatuslineHistoryCommand = { bg = C.mantle, fg = C.mauve },
    StatuslineDiffAdd = { bg = C.mantle, fg = C.green },
    StatuslineDiffChange = { bg = C.mantle, fg = C.yellow },
    StatuslineDiffRemove = { bg = C.mantle, fg = C.red },
    StatuslineDiagnosticError = { bg = C.mantle, fg = C.red },
    StatuslineDiagnosticWarn = { bg = C.mantle, fg = C.yellow },
    StatuslineDiagnosticInfo = { bg = C.mantle, fg = C.sky },
    StatuslineDiagnosticHint = { bg = C.mantle, fg = C.teal },
    StatuslineLazy = { bg = C.mantle, fg = C.pink },
    StatuslineDebug = { bg = C.mantle, fg = C.red },
    StatuslineOverseerRUNNING = { bg = C.mantle, fg = C.yellow },
    StatuslineOverseerSUCCESS = { bg = C.mantle, fg = C.green },
    StatuslineOverseerCANCELED = { bg = C.mantle, fg = C.overlay2 },
    StatuslineOverseerFAILURE = { bg = C.mantle, fg = C.red },
  }
end

return M

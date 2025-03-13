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

    -- snacks
    SnacksPicker = { link = "Normal" },
    SnacksPickerListCursorLine = { link = "VisualFallback" },
    SnacksPickerPreviewCursorLine = { link = "VisualFallback" },

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

    -- dropbar
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

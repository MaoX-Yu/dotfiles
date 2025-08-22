local O = require("catppuccin").options
local C = require("catppuccin.palettes").get_palette(O.flavour)

local catppuccin = {}

local transparent_bg = O.transparent_background and "NONE" or C.mantle

catppuccin.normal = {
  a = { bg = C.mauve, fg = C.mantle, gui = "bold" },
  b = { bg = C.surface0, fg = C.mauve },
  c = { bg = transparent_bg, fg = C.text },
}

catppuccin.insert = {
  a = { bg = C.green, fg = C.base, gui = "bold" },
  b = { bg = C.surface0, fg = C.green },
}

catppuccin.terminal = {
  a = { bg = C.green, fg = C.base, gui = "bold" },
  b = { bg = C.surface0, fg = C.green },
}

catppuccin.command = {
  a = { bg = C.peach, fg = C.base, gui = "bold" },
  b = { bg = C.surface0, fg = C.peach },
}

catppuccin.visual = {
  a = { bg = C.lavender, fg = C.base, gui = "bold" },
  b = { bg = C.surface0, fg = C.lavender },
}

catppuccin.replace = {
  a = { bg = C.red, fg = C.base, gui = "bold" },
  b = { bg = C.surface0, fg = C.red },
}

catppuccin.inactive = {
  a = { bg = transparent_bg, fg = C.mauve },
  b = { bg = transparent_bg, fg = C.surface1, gui = "bold" },
  c = { bg = transparent_bg, fg = C.overlay0 },
}

return catppuccin

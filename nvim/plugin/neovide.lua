if not vim.g.neovide then
  return
end

local g = vim.g
local o = vim.o

local normal_hl = vim.api.nvim_get_hl(0, { id = vim.api.nvim_get_hl_id_by_name("Normal") })

-- Bug
o.winborder = ""

o.guifont = "Maple Mono NF CN:h14"
g.neovide_hide_mouse_when_typing = true
g.neovide_title_background_color = string.format("%x", normal_hl.bg)
g.neovide_title_text_color = string.format("%x", normal_hl.fg)

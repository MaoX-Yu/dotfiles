local wezterm = require("wezterm")
local config = require("config")

local M = {}

-- Approximate display width: East Asian wide characters count as 2 columns,
-- combining and zero-width characters count as 0.
local function display_width(text)
  local width = 0
  for _, cp in utf8.codes(text) do
    local is_wide = (cp >= 0x1100 and cp <= 0x115F)
      or (cp >= 0x2E80 and cp <= 0xA4CF)
      or (cp >= 0xAC00 and cp <= 0xD7A3)
      or (cp >= 0xF900 and cp <= 0xFAFF)
      or (cp >= 0xFE30 and cp <= 0xFE4F)
      or (cp >= 0xFF00 and cp <= 0xFF60)
      or (cp >= 0xFFE0 and cp <= 0xFFE6)
      or (cp >= 0x20000 and cp <= 0x2FFFD)
      or (cp >= 0x30000 and cp <= 0x3FFFD)
    local is_zero_width = (cp >= 0x0300 and cp <= 0x036F)
      or (cp >= 0x200B and cp <= 0x200F)
      or (cp >= 0xFE00 and cp <= 0xFE0F)
      or (cp >= 0xFE20 and cp <= 0xFE2F)
      or (cp >= 0xE0100 and cp <= 0xE01EF)
    if is_zero_width then
      -- counts as zero columns
    elseif is_wide then
      width = width + 2
    else
      width = width + 1
    end
  end
  return width
end

function M.setup()
  wezterm.on("update-right-status", function(window, pane)
    local cells = {}
    local current_time = tonumber(wezterm.strftime("%H"))
    local time_icons = {
      [00] = "",
      [01] = "",
      [02] = "",
      [03] = "",
      [04] = "",
      [05] = "",
      [06] = "",
      [07] = "",
      [08] = "󰗲",
      [09] = "",
      [10] = "",
      [11] = "",
      [12] = "",
      [13] = "",
      [14] = "",
      [15] = "",
      [16] = "󰗲",
      [17] = "",
      [18] = "",
      [19] = "",
      [20] = "",
      [21] = "",
      [22] = "",
      [23] = "",
    }
    local date = wezterm.strftime("%b %d %a")
    local time = wezterm.strftime("%H:%M")
    local date_time = "  " .. date .. "  " .. time_icons[current_time] .. "   " .. time .. " "
    table.insert(cells, date_time)
    local SEPARATOR = "  "
    local palette = {
      "#bb9af7",
      "#7aa2f7",
      "#f7768e",
      "#9ece6a",
      "#7dcfff",
      "#e0af68",
    }
    local cols = pane:get_dimensions().cols
    local padding = wezterm.pad_right("", math.max(0, math.floor((cols / 2) - display_width(date_time) - 2)))
    local elements = {}
    local num_cells = 0

    -- Translate into elements
    local function push(text, is_last)
      local cell_no = num_cells + 1
      if is_last then
        table.insert(elements, { Text = padding })
      end
      table.insert(elements, { Foreground = { Color = palette[cell_no] } })
      table.insert(elements, { Background = { Color = config.colors.transparent } })
      table.insert(elements, { Text = "" .. text .. "" })
      if not is_last then
        table.insert(elements, { Foreground = { Color = config.colors.transparent } })
        table.insert(elements, { Background = { Color = config.colors.transparent } })
        table.insert(elements, { Text = SEPARATOR })
      end
      num_cells = num_cells + 1
    end

    while #cells > 0 do
      local cell = table.remove(cells, 1)
      push(cell, #cells == 0)
    end
    window:set_right_status(wezterm.format(elements))
  end)
end

return M

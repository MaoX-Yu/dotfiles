local Wezterm = require("wezterm")
local Config = require("config")

local M = {}

function M.setup()
  Wezterm.on("update-right-status", function(window, pane)
    local cells = {}
    local current_time = tonumber(Wezterm.strftime("%H"))
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
    local date = Wezterm.strftime("%b %d %a")
    local time = Wezterm.strftime("%H:%M")
    local date_time = "  " .. date .. "  " .. time_icons[current_time] .. "  " .. time .. " "
    table.insert(cells, date_time)
    local SEPERATOR = "  "
    local pallete = {
      "#bb9af7",
      "#7aa2f7",
      "#f7768e",
      "#9ece6a",
      "#7dcfff",
      "#e0af68",
    }
    local cols = pane:get_dimensions().cols
    local padding = Wezterm.pad_right("", (cols / 2) - string.len(date_time) - 2)
    local elements = {}
    local num_cells = 0

    -- Translate into elements
    local function push(text, is_last)
      local cell_no = num_cells + 1
      if is_last then
        table.insert(elements, { Text = padding })
      end
      table.insert(elements, { Foreground = { Color = pallete[cell_no] } })
      table.insert(elements, { Background = { Color = Config.colors.transparent } })
      table.insert(elements, { Text = "" .. text .. "" })
      if not is_last then
        table.insert(elements, { Foreground = { Color = Config.colors.transparent } })
        table.insert(elements, { Background = { Color = Config.colors.transparent } })
        table.insert(elements, { Text = SEPERATOR })
      end
      num_cells = num_cells + 1
    end

    while #cells > 0 do
      local cell = table.remove(cells, 1)
      push(cell, #cells == 0)
    end
    window:set_right_status(Wezterm.format(elements))
  end)
end

return M

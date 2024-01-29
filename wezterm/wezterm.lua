local Wezterm = require("wezterm")
local mux = Wezterm.mux
local Windows = require("windows")
local Linux = require("linux")
local Terminal = require("terminal")
local Icon = require("icon")
local Utils = require("utils")

local C = {}

if Wezterm.config_builder then
  C = Wezterm.config_builder()
end

-- For windows host custom configuration
if Wezterm.target_triple == "x86_64-pc-windows-msvc" then
  Windows.setup(C)
end

-- For linux host custom configuration
if Wezterm.target_triple == "x86_64-unknown-linux-gnu" then
  Linux.setup(C)
end

-- Maximize on startup
-- Wezterm.on("gui-startup", function(cmd)
--   local _, _, window = mux.spawn_window(cmd or {})
--   window:gui_window():maximize()
-- end)

Wezterm.on("mux-startup", function(cmd)
  local _, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():set_inner_size(1280, 720)
  window:gui_window():set_position(980, 60)
  pane:split({ direction = "Bottom", size = 0.25 })
end)

Terminal.setup(C)

-- ===
-- === Window
-- ===
Wezterm.on("window-resized", function(window)
  Utils.recompute_padding(window)
end)

Wezterm.on("window-config-reloaded", function(window)
  Utils.recompute_padding(window)
end)

-- ===
-- === Tab bar
-- ===
Wezterm.on("format-tab-title", function(tab)
  local tab_name = Utils.split(Utils.tab_title(tab), ".")[1]
  tab_name = string.lower(tab_name)
  local icon = Icon.nerdfonts[tab_name] and Icon.nerdfonts[tab_name] .. " " or ""
  if tab.tab_index == 0 then
    return Wezterm.format({
      { Text = " " .. icon .. tab_name .. " " },
      { Text = Icon.SOLID_RIGHT_TRIANGLE },
    })
  else
    return Wezterm.format({
      { Text = Icon.SOLID_LEFT_TRIANGLE },
      { Text = " " .. icon .. tab_name .. " " },
      { Text = Icon.SOLID_RIGHT_TRIANGLE },
    })
  end
end)

Wezterm.on("update-right-status", function(window, pane)
  local cells = {}
  local key_mode = window:active_key_table()
  local mode = {
    ["search_mode"] = "󰜏",
    ["copy_mode"] = "",
  }
  if not key_mode then
    table.insert(cells, "")
  else
    table.insert(cells, mode[key_mode])
  end

  local workspace = window:active_workspace()
  if workspace == "default" then
    workspace = ""
  end
  table.insert(cells, workspace)

  local cwd_uri = pane:get_current_working_dir()
  if cwd_uri then
    local hostname = ""
    if type(cwd_uri) == "userdata" then
      hostname = cwd_uri.host or ""
    else
      cwd_uri = cwd_uri:sub(8)
      local slash = cwd_uri:find("/")
      if slash then
        hostname = cwd_uri:sub(1, slash - 1)
      end
    end

    -- Remove the domain name portion of the hostname
    local dot = hostname:find("[.]")
    if dot then
      hostname = hostname:sub(1, dot - 1)
    end

    if hostname == "" then
      table.insert(cells, "")
    elseif string.find(hostname, "arch") then
      table.insert(cells, "")
    else
      table.insert(cells, "")
    end
  end

  local current_time = tonumber(Wezterm.strftime("%H"))
  local time = {
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
  local date = Wezterm.strftime("%H:%M:%S %a %b %d")
  local date_time = time[current_time] .. " " .. date
  table.insert(cells, date_time)
  local SEPERATOR = "  "
  local pallete = {
    "#f7768e",
    "#9ece6a",
    "#7dcfff",
    "#bb9af7",
    "#e0af68",
    "#7aa2f7",
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
    table.insert(elements, { Background = { Color = Terminal.colors.transparent } })
    table.insert(elements, { Text = "" .. text .. "" })
    if not is_last then
      table.insert(elements, { Foreground = { Color = Terminal.colors.transparent } })
      table.insert(elements, { Background = { Color = Terminal.colors.transparent } })
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

return C

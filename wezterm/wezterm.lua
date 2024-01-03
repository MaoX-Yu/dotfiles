local Wezterm = require("wezterm")
local mux = Wezterm.mux
local Windows = require("windows")
local Linux = require("linux")
local Terminal = require("terminal")
local Icon = require("icon")

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

------------------------------
-- Local Functions
------------------------------
local function recompute_padding(window)
  local window_dims = window:get_dimensions()
  local overrides = window:get_config_overrides() or {}

  if not window_dims.is_full_screen then
    if not overrides.window_padding then
      -- not changing anything
      return
    end
    overrides.window_padding = nil
  else
    -- Use only the middle 33%
    -- local third = math.floor(window_dims.pixel_width / 3)
    local new_padding = {
      left = 0,
      right = 0,
      top = 0,
      bottom = 0,
    }
    if overrides.window_padding and new_padding.left == overrides.window_padding.left then
      -- padding is same, avoid triggering further changes
      return
    end
    overrides.window_padding = new_padding
  end
  window:set_config_overrides(overrides)
end

Wezterm.on("window-resized", function(window)
  recompute_padding(window)
end)

Wezterm.on("window-config-reloaded", function(window)
  recompute_padding(window)
end)

Wezterm.on("format-tab-title", function(tab)
  local function tab_title(tab_info)
    local title = tab_info.tab_title
    if title and #title > 0 then
      return title
    end
    return tab_info.active_pane.title
  end
  local function split(input, delimiter)
    input = tostring(input)
    delimiter = tostring(delimiter)
    if delimiter == "" then
      return false
    end
    local pos, arr = 0, {}
    for st, sp in
      function()
        return string.find(input, delimiter, pos, true)
      end
    do
      table.insert(arr, string.sub(input, pos, st - 1))
      pos = sp + 1
    end
    table.insert(arr, string.sub(input, pos))
    return arr
  end
  local tab_name = split(tab_title(tab), ".")[1]
  local icon = Icon.nerdfonts[tab_name] or ""
  if tab.tab_index == 0 then
    return Wezterm.format({
      -- { Text = " " },
      { Text = " " .. icon .. " " .. tab_name .. " " },
      { Text = Icon.SOLID_RIGHT_TRIANGLE },
    })
  else
    return Wezterm.format({
      { Text = Icon.SOLID_LEFT_TRIANGLE },
      { Text = " " .. icon .. " " .. tab_name .. " " },
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
    cwd_uri = cwd_uri:sub(8)
    local slash = cwd_uri:find("/")
    -- local cwd = ""
    local hostname = ""
    if slash then
      hostname = cwd_uri:sub(1, slash - 1)
      -- Remove the domain name portion of the hostname
      local dot = hostname:find("[.]")
      if dot then
        hostname = hostname:sub(1, dot - 1)
      end
      -- and extract the cwd from the uri
      -- cwd = cwd_uri:sub(slash)
      -- table.insert(cells, cwd)
      if hostname == "" then
        table.insert(cells, "")
      elseif string.find(hostname, "arch") then
        table.insert(cells, "")
      else
        table.insert(cells, "")
      end
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
  local date = Wezterm.strftime("%H:%M:%S %a %b %d ")
  local date_time = time[current_time] .. " " .. date
  table.insert(cells, date_time)
  -- local text_fg = Terminal.colors.transparent
  -- local SEPERATOR = " █"
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
      -- table.insert(elements, text_fg)
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

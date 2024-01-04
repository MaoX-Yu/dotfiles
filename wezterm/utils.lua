local M = {}

-- Special
local apps = { "Lazygit" }
local signs = { ":" }

function string.ends(str, end_str)
  return end_str == "" or string.sub(str, -string.len(end_str)) == end_str
end

function M.recompute_padding(window)
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

function M.tab_title(tab_info)
  local title = tab_info.tab_title
  if title == nil or #title <= 0 then
    title = tab_info.active_pane.title
  end
  for _, app in pairs(apps) do
    if string.ends(title, app) then
      return app
    end
  end
  title = M.split(title, " ")[1]
  for _, sign in pairs(signs) do
    title = string.gsub(title, sign, "")
  end

  title = string.gsub(title, "\\", "/")
  title = M.split(title, "/")
  if title then
    title = title[#title]
  end
  return title
end

function M.split(input, delimiter)
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

return M

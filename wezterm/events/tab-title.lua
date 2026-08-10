local wezterm = require("wezterm")
local config = require("config")

local GLYPH_SEMI_CIRCLE_LEFT = ""
local GLYPH_SEMI_CIRCLE_RIGHT = ""
local GLYPH_CIRCLE = " "
local GLYPH_ADMIN = "󱥠 "

local GLYPH_STATIC = wezterm.nerdfonts.cod_book
local GLYPH_APP_TITLE = wezterm.nerdfonts.cod_terminal
local GLYPH_FOLDER = wezterm.nerdfonts.md_folder

local M = {}

M.cells = {}

-- Display width: East Asian wide characters count as 2 columns,
-- combining and zero-width characters count as 0.
local function display_width(text)
  local width = 0
  local ok = pcall(function()
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
  end)
  if not ok then
    return #text
  end
  return width
end

local function urldecode(s)
  return s:gsub("%%(%x%x)", function(hex)
    return string.char(tonumber(hex, 16))
  end)
end

-- Trim leading/trailing whitespace
local function trim(s)
  return s:gsub("^%s+", ""):gsub("%s+$", "")
end

-- Normalize Windows path separators to forward slashes
local function to_forward_slashes(s)
  return s:gsub("\\", "/")
end

-- Last path component, after any / or \ separator
local function basename(s)
  return s:gsub(".*[/\\]", "")
end

-- Strip a trailing .exe suffix (Windows executables)
local function strip_exe(s)
  return s:gsub("%.exe$", "")
end

M.colors = {
  default = {
    bg = config.colors.tab_inactive,
    fg = config.colors.crust,
  },
  is_active = {
    bg = config.colors.tab_active,
    fg = config.colors.crust,
  },

  hover = {
    bg = config.colors.tab_hover,
    fg = config.colors.crust,
  },
}

-- Normalize a file URL or raw path into a displayable, forward-slash path.
function M.clean_path(raw)
  -- Strip the scheme:// prefix, e.g. file:// or wsl+Ubuntu://
  local path = raw:gsub("^[^:]+://", "")
  -- Windows drive paths come through as /C:/...; drop the leading slash
  if path:match("^/[A-Za-z]:") then
    path = path:sub(2)
  end
  -- Backslashes are garbage; always use forward slashes
  path = to_forward_slashes(path)
  -- Trailing slashes
  path = path:gsub("/+$", "")
  path = urldecode(path)
  if path == "" then
    return nil
  end
  return path
end

function M.is_windows_path(s)
  return s:match("^[A-Za-z]:[\\/]") ~= nil or s:match("^\\\\") ~= nil
end

-- Console shells that set the terminal title to their own executable path
-- when spawned (e.g. cmd.exe on Windows); treat those titles as noise.
local NOISE_SHELLS = {
  "cmd",
  "conhost",
  "powershell",
  "pwsh",
}

function M.is_shell_noise_title(s)
  local lower = strip_exe(s:lower())
  for _, name in ipairs(NOISE_SHELLS) do
    if lower == name then
      return true
    end
  end
  if M.is_windows_path(s) then
    local base = M.clean_path(s)
    if base then
      base = strip_exe(basename(base):lower())
      for _, name in ipairs(NOISE_SHELLS) do
        if base == name then
          return true
        end
      end
    end
  end
  return false
end

-- Clean the pane cwd into a displayable, forward-slash path, or nil.
function M.get_cwd_display(pane)
  local ok, cwd = pcall(function()
    return pane:get_current_working_dir()
  end)
  if not ok or not cwd then
    return nil
  end

  local raw
  local ok_field, field = pcall(function()
    return cwd.file_path
  end)
  if ok_field and type(field) == "string" and field ~= "" then
    raw = field
  else
    local str = tostring(cwd)
    if type(str) ~= "string" or str == "" then
      return nil
    end
    raw = str
  end

  return M.clean_path(raw)
end

-- True when a title is (or contains) a path-like string, so that long
-- titles can be shortened to their final directory.
local function is_path(s)
  return s:match("[\\/]") ~= nil or s:match("^[A-Za-z]+://") ~= nil
end

-- Reduce a path to its last directory plus anything after it:
-- "C:/a/b/c/file.txt" -> "c/file.txt", "C:/a/b/c" -> "c".
local function shorten_path(path)
  local parts = {}
  for part in path:gmatch("[^/]+") do
    table.insert(parts, part)
  end
  if #parts <= 1 then
    return path
  end
  -- A final component that looks like a file (dot past the first char)
  -- keeps its parent directory, e.g. C:/.../System32/cmd.exe -> System32/cmd.exe
  if parts[#parts]:find(".", 2, true) then
    return parts[#parts - 1] .. "/" .. parts[#parts]
  end
  return parts[#parts]
end

function M.set_title(static_title, app_title, app_path, cwd_path, process_name, max_width, inset)
  inset = inset or 6
  local title
  local icon

  if static_title:len() > 0 then
    icon = GLYPH_STATIC
    title = static_title
  elseif app_title:len() > 0 then
    icon = GLYPH_APP_TITLE
    title = app_title
  elseif app_path or cwd_path then
    icon = GLYPH_FOLDER
    title = app_path or cwd_path
  else
    icon = GLYPH_APP_TITLE
    title = process_name
  end

  -- Windows shells report paths with backslashes (e.g. C:\Users\...),
  -- even inside otherwise non-path titles; normalize them so tab titles
  -- always use forward slashes.
  title = to_forward_slashes(title)

  local result = icon .. "  " .. title
  if max_width and max_width > 0 and display_width(result) > max_width - inset then
    -- Long path-like titles keep only the last directory and whatever
    -- follows it; anything else falls back to truncation.
    if is_path(title) then
      title = shorten_path(title)
      result = icon .. "  " .. title
    end
    if display_width(result) > max_width - inset then
      result = wezterm.truncate_right(result, max_width - inset)
    end
  end
  return result
end

function M.check_if_admin(p)
  if p:match("^Administrator: ") then
    return true
  end
  return false
end

---@param fg string
---@param bg string
---@param attribute table
---@param text string
function M.push(bg, fg, attribute, text)
  table.insert(M.cells, { Background = { Color = bg } })
  table.insert(M.cells, { Foreground = { Color = fg } })
  table.insert(M.cells, { Attribute = attribute })
  table.insert(M.cells, { Text = text })
end

-- Safely read a string from a pane: each accessor is tried in order and may
-- be a method name or a field name; falls back to "".
local function pane_string(pane, ...)
  for _, accessor in ipairs({ ... }) do
    local ok, value = pcall(function()
      if type(pane[accessor]) == "function" then
        return pane[accessor](pane)
      end
      return pane[accessor]
    end)
    if ok and value and tostring(value) ~= "" then
      return tostring(value)
    end
  end
  return ""
end

function M.setup()
  wezterm.on("format-tab-title", function(tab, _, _, _, hover, max_width)
    M.cells = {}

    local bg
    local fg
    local pane = tab.active_pane

    -- Raw foreground process name (full path), with fallbacks
    local raw_process = pane_string(pane, "get_foreground_process_name", "foreground_process_name")
    local default_title = basename(raw_process)
    local process_name = strip_exe(default_title)

    -- Application-provided title: non-empty and different from the default
    -- process-name title
    local pane_title = trim(pane_string(pane, "title", "get_title"))

    local app_title = ""
    local app_path = nil
    if pane_title ~= "" and pane_title ~= default_title and not M.is_shell_noise_title(pane_title) then
      if M.is_windows_path(pane_title) then
        app_path = M.clean_path(pane_title)
      else
        app_title = pane_title
      end
    end

    local is_admin = M.check_if_admin(pane_title)
    local cwd_path = M.get_cwd_display(pane)

    local has_unseen_output = false
    for _, pane in ipairs(tab.panes) do
      if pane.has_unseen_output then
        has_unseen_output = true
        break
      end
    end

    -- Exact width budget for the decorations pushed around the title:
    -- semi-circles + padding (4), admin icon (+2), unseen dot (+2)
    local inset = 4 + (is_admin and 2 or 0) + (has_unseen_output and 2 or 0)
    local title = M.set_title(tab.tab_title or "", app_title, app_path, cwd_path, process_name, max_width, inset)

    if tab.is_active then
      bg = M.colors.is_active.bg
      fg = M.colors.is_active.fg
    elseif hover then
      bg = M.colors.hover.bg
      fg = M.colors.hover.fg
    else
      bg = M.colors.default.bg
      fg = M.colors.default.fg
    end

    -- Left semi-circle
    M.push(fg, bg, { Intensity = "Bold" }, GLYPH_SEMI_CIRCLE_LEFT)

    -- Admin Icon
    if is_admin then
      M.push(bg, fg, { Intensity = "Bold" }, " " .. GLYPH_ADMIN)
    end

    -- Title
    M.push(bg, fg, { Intensity = "Bold" }, " " .. title)

    -- Unseen output alert
    if has_unseen_output then
      M.push(bg, "#FF3B8B", { Intensity = "Bold" }, " " .. GLYPH_CIRCLE)
    end

    -- Right padding
    M.push(bg, fg, { Intensity = "Bold" }, " ")

    -- Right semi-circle
    M.push(fg, bg, { Intensity = "Bold" }, GLYPH_SEMI_CIRCLE_RIGHT)

    return M.cells
  end)
end

return M

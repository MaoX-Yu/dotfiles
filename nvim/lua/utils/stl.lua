local M = {}

-- stylua: ignore
M.hl_groups = {
  normal          = { "StatusLineNormal", "StatusLineNormalB" },
  insert          = { "StatusLineInsert", "StatusLineInsertB" },
  terminal        = { "StatusLineTerminal", "StatusLineTerminalB" },
  command         = { "StatusLineCommand", "StatusLineCommandB" },
  visual          = { "StatusLineVisual", "StatusLineVisualB" },
  replace         = { "StatusLineReplace", "StatusLineReplaceB" },
  history_command = "StatusLineHistoryCommand",
  diff_add        = "StatusLineAdd",
  diff_change     = "StatusLineChange",
  diff_remove     = "StatusLineRemove",
  error           = "StatusLineError",
  warn            = "StatusLineWarn",
  info            = "StatusLineInfo",
  hint            = "StatusLineHint",
  lazy            = "StatusLineLazy",
  debug           = "StatusLineDebug",
  RUNNING         = "StatusLineOverseerRUNNING",
  SUCCESS         = "StatusLineOverseerSUCCESS",
  CANCELED        = "StatusLineOverseerCANCELED",
  FAILURE         = "StatusLineOverseerFAILURE",
}

-- stylua: ignore
local modes = {
  ["n"]     = "NORMAL",
  ["no"]    = "O-PENDING",
  ["nov"]   = "O-PENDING",
  ["noV"]   = "O-PENDING",
  ["no\22"] = "O-PENDING",
  ["niI"]   = "NORMAL",
  ["niR"]   = "NORMAL",
  ["niV"]   = "NORMAL",
  ["nt"]    = "NORMAL",
  ["ntT"]   = "NORMAL",
  ["v"]     = "VISUAL",
  ["vs"]    = "VISUAL",
  ["V"]     = "V-LINE",
  ["Vs"]    = "V-LINE",
  ["\22"]   = "V-BLOCK",
  ["\22s"]  = "V-BLOCK",
  ["s"]     = "SELECT",
  ["S"]     = "S-LINE",
  ["\19"]   = "S-BLOCK",
  ["i"]     = "INSERT",
  ["ic"]    = "INSERT",
  ["ix"]    = "INSERT",
  ["R"]     = "REPLACE",
  ["Rc"]    = "REPLACE",
  ["Rx"]    = "REPLACE",
  ["Rv"]    = "V-REPLACE",
  ["Rvc"]   = "V-REPLACE",
  ["Rvx"]   = "V-REPLACE",
  ["c"]     = "COMMAND",
  ["cv"]    = "EX",
  ["ce"]    = "EX",
  ["r"]     = "REPLACE",
  ["rm"]    = "MORE",
  ["r?"]    = "CONFIRM",
  ["!"]     = "SHELL",
  ["t"]     = "TERMINAL",
}

-- stylua: ignore
local mode_to_hl = {
  ["VISUAL"]    = M.hl_groups.visual,
  ["V-BLOCK"]   = M.hl_groups.visual,
  ["V-LINE"]    = M.hl_groups.visual,
  ["SELECT"]    = M.hl_groups.visual,
  ["S-LINE"]    = M.hl_groups.visual,
  ["S-BLOCK"]   = M.hl_groups.visual,
  ["REPLACE"]   = M.hl_groups.replace,
  ["V-REPLACE"] = M.hl_groups.replace,
  ["INSERT"]    = M.hl_groups.insert,
  ["COMMAND"]   = M.hl_groups.command,
  ["EX"]        = M.hl_groups.command,
  ["MORE"]      = M.hl_groups.command,
  ["CONFIRM"]   = M.hl_groups.command,
  ["TERMINAL"]  = M.hl_groups.terminal,
}

---Get mode string and highlight group name
---@param mode string @nvim mode
---@return string mode_str @mode string
---@return string[] hl @highlight group name
function M.get_mode_hl(mode)
  local mode_str = modes[mode]
  local hl = mode_to_hl[mode_str] or M.hl_groups.normal
  return mode_str, hl
end

---Get string representation of a string with highlight
---@param str? string @sign symbol
---@param hl? string @name of the highlight group
---@param restore? boolean @restore highlight after the sign, default true
---@return string sign @string representation of the sign with highlight
function M.hl(str, hl, restore)
  restore = restore == nil or restore
  return restore and table.concat({ "%#", hl, "#", str or "", "%*" }) or table.concat({ "%#", hl, "#", str or "" })
end

---Escape '%' with '%' in a string to avoid it being treated as a statusline
---field, see `:h 'statusline'`
---@param str string
---@return string
function M.escape(str)
  return (str:gsub("%%", "%%%%"))
end

---Convert a snake_case string to camelCase
---@param str string?
---@return string
function M.snake_to_camel(str)
  if not str then
    return ""
  end
  return (str:gsub("^%l", string.upper):gsub("_%l", string.upper):gsub("_", ""))
end

return M

---Statusline utils
local M = {}

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
  ["VISUAL"]    = "StatuslineVisual",
  ["V-BLOCK"]   = "StatuslineVisual",
  ["V-LINE"]    = "StatuslineVisual",
  ["SELECT"]    = "StatuslineVisual",
  ["S-LINE"]    = "StatuslineVisual",
  ["S-BLOCK"]   = "StatuslineVisual",
  ["REPLACE"]   = "StatuslineReplace",
  ["V-REPLACE"] = "StatuslineReplace",
  ["INSERT"]    = "StatuslineInsert",
  ["COMMAND"]   = "StatuslineCommand",
  ["EX"]        = "StatuslineCommand",
  ["MORE"]      = "StatuslineCommand",
  ["CONFIRM"]   = "StatuslineCommand",
  ["TERMINAL"]  = "StatuslineTerminal",
}

local diag_signs_text = { "E:", "W:", "I:", "H:" }

local diag_severity_map = {
  [1] = "ERROR",
  [2] = "WARN",
  [3] = "INFO",
  [4] = "HINT",
  ERROR = 1,
  WARN = 2,
  INFO = 3,
  HINT = 4,
}

---Get diagnostic sign text
---@param severity integer|string
---@return string
function M.get_diag_sign_text(severity)
  return diag_signs_text[severity] or diag_signs_text[diag_severity_map[severity]]
end

---Get mode string and highlight group name
---@param mode string @nvim mode
---@return string mode_str @mode string
---@return string hl @highlight group name
function M.get_mode_hl(mode)
  local mode_str = modes[mode]
  local hl = mode_to_hl[mode_str] or "StatuslineNormal"
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
---@return string?
function M.snake_to_camel(str)
  if not str then
    return nil
  end
  return (str:gsub("^%l", string.upper):gsub("_%l", string.upper):gsub("_", ""))
end

return M

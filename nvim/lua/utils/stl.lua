---@class StlUtils
local M = {}

-- stylua: ignore
M.hl_groups = {
  showcmd     = "StatusLineShowcmd",
  diff_add    = "StatusLineAdd",
  diff_change = "StatusLineChange",
  diff_remove = "StatusLineRemove",
  error       = "StatusLineError",
  warn        = "StatusLineWarn",
  info        = "StatusLineInfo",
  hint        = "StatusLineHint",
  lazy        = "StatusLineLazy",
  debug       = "StatusLineDebug",
  RUNNING     = "StatusLineOverseerRUNNING",
  SUCCESS     = "StatusLineOverseerSUCCESS",
  CANCELED    = "StatusLineOverseerCANCELED",
  FAILURE     = "StatusLineOverseerFAILURE",
}

---Get string representation of a string with highlight
---@param str string? @sign symbol
---@param hl string? @name of the highlight group
---@param restore boolean? @restore highlight after the sign, default true
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

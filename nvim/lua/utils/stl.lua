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

-- stylua: ignore
local modes = {
  ["n"]     = "N",
  ["no"]    = "O",
  ["nov"]   = "O",
  ["noV"]   = "O",
  ["no\22"] = "O",
  ["niI"]   = "N",
  ["niR"]   = "N",
  ["niV"]   = "N",
  ["nt"]    = "N",
  ["ntT"]   = "N",
  ["v"]     = "V",
  ["vs"]    = "V",
  ["V"]     = "V-L",
  ["Vs"]    = "V-L",
  ["\22"]   = "V-B",
  ["\22s"]  = "V-B",
  ["s"]     = "S",
  ["S"]     = "S-L",
  ["\19"]   = "S-B",
  ["i"]     = "I",
  ["ic"]    = "I",
  ["ix"]    = "I",
  ["R"]     = "R",
  ["Rc"]    = "R",
  ["Rx"]    = "R",
  ["Rv"]    = "R",
  ["Rvc"]   = "R",
  ["Rvx"]   = "R",
  ["c"]     = "C",
  ["cv"]    = "E",
  ["ce"]    = "E",
  ["r"]     = "R",
  ["rm"]    = "M",
  ["r?"]    = "C",
  ["!"]     = "SH",
  ["t"]     = "T",
}

---@alias ModeStr
---| "N"
---| "I"
---| "O"
---| "V"
---| "V-L"
---| "V-B"
---| "S"
---| "S-L"
---| "S-B"
---| "R"
---| "C"
---| "E"
---| "M"
---| "SH"
---| "T"

---Get mode string
---@param mode string @nvim mode
---@return ModeStr? mode_str @mode string
function M.get_mode(mode)
  return modes[mode]
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

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
  ["n"]     = "NOR",
  ["no"]    = "OPER",
  ["nov"]   = "OPER",
  ["noV"]   = "OPER",
  ["no\22"] = "OPER",
  ["niI"]   = "NOR",
  ["niR"]   = "NOR",
  ["niV"]   = "NOR",
  ["nt"]    = "NOR",
  ["ntT"]   = "NOR",
  ["v"]     = "VIS",
  ["vs"]    = "VIS",
  ["V"]     = "V-LN",
  ["Vs"]    = "V-LN",
  ["\22"]   = "V-BLK",
  ["\22s"]  = "V-BLK",
  ["s"]     = "SEL",
  ["S"]     = "S-LN",
  ["\19"]   = "S-BLK",
  ["i"]     = "INS",
  ["ic"]    = "INS",
  ["ix"]    = "INS",
  ["R"]     = "REP",
  ["Rc"]    = "REP",
  ["Rx"]    = "REP",
  ["Rv"]    = "REP",
  ["Rvc"]   = "REP",
  ["Rvx"]   = "REP",
  ["c"]     = "CMD",
  ["cr"]     = "CMD",
  ["cv"]    = "EX",
  ["cvr"]    = "EX",
  ["r"]     = "H-CR",
  ["rm"]    = "MORE",
  ["r?"]    = "CFM",
  ["!"]     = "SH",
  ["t"]     = "TERM",
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

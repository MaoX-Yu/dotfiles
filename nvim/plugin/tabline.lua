local utils = require("utils.stl")
local api = vim.api
local fn = vim.fn

local M = {}

---@param bufnr integer
---@return string
local function buffer_label(bufnr)
  local buftype = vim.bo[bufnr].buftype
  if buftype ~= "" then
    local filetype = vim.bo[bufnr].filetype
    local type_name = filetype ~= "" and filetype or buftype
    local label = type_name == "qf" and "Quickfix" or utils.snake_to_camel(type_name)
    return string.format("[%s]", utils.escape(label))
  end

  local name = api.nvim_buf_get_name(bufnr)
  if name == "" then
    return "[Scratch]"
  end

  return utils.escape(fn.fnamemodify(name, ":t"))
end

---@param tabnr integer
---@param hl string
---@return string
local function tab_label(tabnr, hl)
  local buflist = fn.tabpagebuflist(tabnr)
  local current_buf = buflist[fn.tabpagewinnr(tabnr)]
  local prefix = ""

  local wincount = fn.tabpagewinnr(tabnr, "$")
  if wincount > 1 then
    prefix = string.format("%%#Title#%d%%#%s#", wincount, hl)
  end

  for _, bufnr in ipairs(buflist) do
    if vim.bo[bufnr].modified then
      prefix = prefix .. "+"
      break
    end
  end

  if prefix ~= "" then
    prefix = prefix .. " "
  end

  return prefix .. buffer_label(current_buf)
end

---@return string
function M.get()
  local tabline = {}
  local current_tab = fn.tabpagenr()

  for tabnr = 1, fn.tabpagenr("$") do
    local hl = tabnr == current_tab and "TabLineSel" or "TabLine"
    tabline[#tabline + 1] = string.format("%%#%s#%%%dT %s ", hl, tabnr, tab_label(tabnr, hl))
  end

  tabline[#tabline + 1] = "%#TabLineFill#%T"
  return table.concat(tabline)
end

_G.tabline = M.get

vim.go.tabline = [[%!v:lua.tabline()]]

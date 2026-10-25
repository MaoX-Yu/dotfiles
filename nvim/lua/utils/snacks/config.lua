-- Adapted from folke/snacks.nvim v2.31.0 (882c996c); modified locally.
-- Apache-2.0. See ATTRIBUTION.md.
local M = {}

local values = {
  styles = {},
}

local function is_dict_like(value)
  return type(value) == "table" and (vim.tbl_isempty(value) or not vim.islist(value))
end

local function is_dict(value)
  return type(value) == "table" and (vim.tbl_isempty(value) or not value[1])
end

---Merge values like `vim.tbl_deep_extend("force", ...)`, including non-table values.
---@param ... any
---@return any
function M.merge(...)
  local result = select(1, ...)
  for i = 2, select("#", ...) do
    local value = select(i, ...)
    if is_dict_like(result) and is_dict(value) then
      for key, child in pairs(value) do
        result[key] = M.merge(result[key], child)
      end
    elseif value ~= nil then
      result = value
    end
  end
  return result
end

---Resolve a feature's defaults with the user configuration and per-call options.
---@generic T: table
---@param name string
---@param defaults T
---@param ... T[]
---@return T
function M.get(name, defaults, ...)
  local merged = { vim.deepcopy(defaults), vim.deepcopy(values[name] or {}) }
  for i = 1, select("#", ...) do
    table.insert(merged, vim.deepcopy(select(i, ...)))
  end
  return M.merge(unpack(merged))
end

---Register a named window style.
---@param name string
---@param defaults table
function M.style(name, defaults)
  values.styles[name] = vim.tbl_deep_extend("force", vim.deepcopy(defaults), values.styles[name] or {})
end

---Apply the top-level feature configuration.
---@param opts table
function M.setup(opts)
  values = vim.tbl_deep_extend("force", values, opts)
end

return setmetatable(M, {
  __index = function(_, key)
    values[key] = values[key] or {}
    return values[key]
  end,
})

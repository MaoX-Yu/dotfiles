local M = {}

---Check os is windows or not
---@return boolean
function M.is_windows()
  return vim.loop.os_uname().sysname:find("Windows", 1, true) ~= nil
end

---Check if the extra is enabled
---@param extra string @extra name
---@return boolean
function M.has_extra(extra)
  extra = "lazyvim.plugins.extras." .. extra
  local path = vim.fn.stdpath("config") .. "/lazyvim.json"
  local file = io.open(path, "r")

  if file == nil then
    return false
  end
  local data = file:read("*a")
  file:close()

  return data:find(extra) ~= nil
end

local U = {
  is_windows = M.is_windows,
  has_extra = M.has_extra,
}

return U

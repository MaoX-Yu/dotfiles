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

---Load nvim options
---@param opts table @options
function M.load_opts(opts)
  for scope, tbl in pairs(opts) do
    for setting, val in pairs(tbl) do
      vim[scope][setting] = val
    end
  end
end

---Load keymaps
---@param maps List @map keys
---@param unmaps List @unmap keys
function M.load_keymaps(maps, unmaps)
  -- del keys
  for _, unmap in pairs(unmaps) do
    vim.keymap.del(unmap.mode, unmap.key, unmap.opts or {})
  end
  -- set keys
  for _, map in pairs(maps) do
    vim.keymap.set(map.mode, map.from, map.to, map.opts or {})
  end
end

return M

---Core utils
local M = {}

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
---@param maps table[] @map keys
---@param unmaps table[] @unmap keys
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

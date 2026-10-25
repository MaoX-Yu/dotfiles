-- Adapted from folke/snacks.nvim v2.31.0 (882c996c); modified locally.
-- Apache-2.0. See ATTRIBUTION.md.
---@class mao.utils.snacks.History
---@field path string
---@field kv mao.utils.snacks.KeyValue
---@field idx number
---@field cursor number
local M = {}
M.__index = M

---@type table<string, mao.utils.snacks.KeyValue>
M.stores = {}

local uv = vim.uv or vim.loop

-- Save the history on exit
vim.api.nvim_create_autocmd("ExitPre", {
  group = vim.api.nvim_create_augroup("mao_history", { clear = true }),
  callback = function()
    for n, kv in pairs(M.stores) do
      kv:close()
      M.stores[n] = nil
    end
  end,
})

---@param name string
---@param opts? {filter?: fun(value: string): boolean}
function M.new(name, opts)
  opts = opts or {}
  local self = setmetatable({}, M)
  self.path = vim.fn.stdpath("data") .. "/mao/" .. name .. ".history"
  if not M.stores[name] then
    M.stores[name] = require("utils.snacks.kv").new(self.path, {
      max_size = 1000,
      ---@param a mao.utils.snacks.KeyValue.entry
      ---@param b mao.utils.snacks.KeyValue.entry
      cmp = function(a, b)
        return a.key > b.key
      end,
    })
    local legacy = vim.fn.stdpath("data") .. "/snacks/" .. name .. ".history"
    if not uv.fs_stat(self.path) and uv.fs_stat(legacy) then
      M.stores[name].data = require("utils.snacks.kv").new(legacy).data
    end
  end
  self.kv = M.stores[name]
  -- re-index the data
  self.kv.data = vim.tbl_values(self.kv.data)
  if opts.filter then
    self.kv.data = vim.tbl_filter(opts.filter, self.kv.data)
  end
  self.idx = #self.kv.data + 1
  self.cursor = self.idx

  return self
end

function M:is_current()
  return self.cursor == self.idx
end

function M:record(value)
  -- don't record value if it's identical to the last recorded value
  if vim.deep_equal(self.kv:get(math.max(self.idx - 1, 1)), value) then
    return
  end
  self.kv:set(self.idx, value)
end

function M:next()
  self.cursor = math.min(self.cursor + 1, self.idx)
  return self:get()
end

function M:prev()
  self.cursor = math.max(self.cursor - 1, 1)
  return self:get()
end

function M:get()
  return self.kv:get(self.cursor)
end

return M

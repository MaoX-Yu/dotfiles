-- Adapted from folke/snacks.nvim v2.31.0 (882c996c); modified locally.
-- Apache-2.0. See ATTRIBUTION.md.
---@class mao.utils.snacks.KeyValue
---@field data table<string, number>
---@field loaded_time number
---@field path string
---@field max_size number
---@field cmp fun(a:mao.utils.snacks.KeyValue.entry, b:mao.utils.snacks.KeyValue.entry): boolean
local M = {}
M.__index = M
local uv = vim.uv or vim.loop

---@alias mao.utils.snacks.KeyValue.entry {key:string, value:number}

---@param path string
---@param opts? {max_size?: number, cmp?: fun(a:mao.utils.snacks.KeyValue.entry, b:mao.utils.snacks.KeyValue.entry): boolean}
function M.new(path, opts)
  local self = setmetatable({}, M)
  self.data = {}
  self.path = path
  self.max_size = opts and opts.max_size or 10000
  ---@param a mao.utils.snacks.KeyValue.entry
  ---@param b mao.utils.snacks.KeyValue.entry
  self.cmp = opts and opts.cmp or function(a, b)
    return a.value > b.value
  end
  self.loaded_time = os.time()
  local fd = io.open(path, "rb")
  if fd then
    ---@type string
    local data = fd:read("*a")
    fd:close()
    local ok, decoded = pcall(require("string.buffer").decode, data)
    self.data = ok and decoded or {} --[[@as table<string, number>]]
  end
  return self
end

function M:set(key, value)
  self.data[key] = value
end

function M:get(key)
  return self.data[key]
end

function M:get_all()
  return self.data
end

function M:close()
  vim.fn.mkdir(vim.fn.fnamemodify(self.path, ":h"), "p")
  local stat = uv.fs_stat(self.path)
  -- check if the file was modified since we loaded it
  if self.loaded_time > 0 and stat and stat.mtime.sec > self.loaded_time then
    return
  end
  local entries = {} ---@type mao.utils.snacks.KeyValue.entry[]
  for k, v in pairs(self.data) do
    table.insert(entries, { key = k, value = v })
  end
  table.sort(entries, self.cmp)

  self.data = {}
  for i = 1, math.min(#entries, self.max_size) do
    local entry = entries[i]
    self.data[entry.key] = entry.value
  end
  local data = require("string.buffer").encode(self.data)
  local fd = io.open(self.path, "w+b")
  if not fd then
    return
  end
  fd:write(data)
  fd:close()
end

return M

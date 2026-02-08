---@class PackUtils
local M = {}

---Split string by space
---@param str string
---@return string[]
local function split(str)
  local results = {}
  for word in string.gmatch(str, "%S+") do
    table.insert(results, word)
  end
  return results
end

---Lazy load plugin by Command, Autocmd and FileType
---@param plug vim.pack.Plug @plugin
function M.lazy(plug)
  local data = plug.spec.data or {}
  if not data.cmd and not data.event and not data.ft then
    vim.cmd.packadd(plug.spec.name)
    if data.config then
      data.config()
    end
    return
  end

  if data.cmd then
    for _, cmd in ipairs(data.cmd) do
      vim.api.nvim_create_user_command(cmd, function()
        vim.cmd.packadd(plug.spec.name)
        if data.config then
          data.config()
        end
        vim.cmd(cmd)
      end, {})
    end
  end

  if data.event or data.ft then
    local group = vim.api.nvim_create_augroup("mao.pack." .. plug.spec.name, { clear = true })

    data.event = data.event or {}
    if data.ft then
      table.insert(data.event, "FileType")
    end

    for _, ev in ipairs(data.event) do
      local lst = split(ev)
      local event = lst[1]
      local pattern = event == "FileType" and data.ft or lst[2]
      vim.api.nvim_create_autocmd(event --[[@as vim.api.keyset.events]], {
        group = group,
        pattern = pattern,
        callback = function()
          vim.cmd.packadd(plug.spec.name)
          if data.config then
            data.config()
          end
          vim.api.nvim_del_augroup_by_id(group)
        end,
      })
    end
  end
end

---@class mao.pack.map.Spec
---@field [1] string
---@field [2] string | function
---@field mode string | string[] | nil
---@field desc string?
---@field expr boolean?
---@field nowait boolean?

---Mappings
---@param specs mao.pack.map.Spec[]
function M.map(specs)
  for _, spec in ipairs(specs) do
    vim.keymap.set(spec.mode or "n", spec[1], spec[2], { desc = spec.desc, nowait = spec.nowait, expr = spec.expr })
  end
end

return M

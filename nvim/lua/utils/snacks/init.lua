-- Adapted from folke/snacks.nvim v2.31.0 (882c996c); modified locally.
-- Apache-2.0. See ATTRIBUTION.md.
---@class mao.utils.snacks
local config = require("utils.snacks.config")
local M = {}

setmetatable(M, {
  __index = function(self, key)
    self[key] = require("utils.snacks." .. key)
    return self[key]
  end,
})

M.config = config
M.version = "2.31.0-cropped"
M.upstream = {
  repository = "https://github.com/folke/snacks.nvim",
  version = "2.31.0",
  commit = "882c996cf28183f4d63640de0b4c02ec886d01f2",
}
M.did_setup = false

---@param opts table
function M.setup(opts)
  if M.did_setup then
    return vim.notify("utils.snacks is already set up", vim.log.levels.ERROR, { title = "Mao" })
  end
  M.did_setup = true

  opts = opts or {}
  for _, value in pairs(opts) do
    if type(value) == "table" then
      value.enabled = value.enabled == nil or value.enabled
    end
  end
  config.setup(opts)

  local events = {
    BufReadPre = { "bigfile" },
    BufReadPost = { "quickfile", "indent" },
    LspAttach = { "words" },
    UIEnter = { "input", "scope" },
  }

  ---@param event string
  local function load(event)
    local pending = events[event] or {}
    events[event] = nil
    for _, feature in ipairs(pending) do
      if M.config[feature] and M.config[feature].enabled then
        if M[feature].setup then
          M[feature].setup()
        elseif M[feature].enable then
          M[feature].enable()
        end
      end
    end
  end

  if vim.v.vim_did_enter == 1 then
    load("UIEnter")
  end

  local group = vim.api.nvim_create_augroup("mao_snacks", { clear = true })
  vim.api.nvim_create_autocmd(vim.tbl_keys(events), {
    group = group,
    once = true,
    nested = true,
    callback = function(ev)
      load(ev.event)
    end,
  })
end

return M

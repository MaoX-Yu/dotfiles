local keymaps = require("utils.keymaps")
local stl = require("utils.stl")

local M = {
  keymaps = keymaps,
  stl = stl,
}

return setmetatable(M, {
  __index = function(self, key)
    self[key] = require("utils." .. key)
    return self[key]
  end,
})

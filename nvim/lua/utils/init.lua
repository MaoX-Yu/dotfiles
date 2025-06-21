local keymaps = require("utils.keymaps")

local M = {
  keymaps = keymaps,
}

return setmetatable(M, {
  __index = function(self, key)
    self[key] = require("utils." .. key)
    return self[key]
  end,
})

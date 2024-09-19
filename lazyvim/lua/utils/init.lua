return setmetatable({}, {
  __index = function(tbl, key)
    ---@diagnostic disable-next-line: no-unknown
    tbl[key] = require("utils." .. key)
    return tbl[key]
  end,
})

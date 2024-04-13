local Wezterm = require("wezterm")
local Utils = require("utils")

local M = {}

function M.setup()
  Wezterm.on("window-resized", function(window)
    Utils.recompute_padding(window)
  end)

  Wezterm.on("window-config-reloaded", function(window)
    Utils.recompute_padding(window)
  end)
end

return M

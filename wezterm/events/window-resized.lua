local wezterm = require("wezterm")
local utils = require("utils")

local M = {}

function M.setup()
  wezterm.on("window-resized", function(window)
    utils.recompute_padding(window)
  end)

  wezterm.on("window-config-reloaded", function(window)
    utils.recompute_padding(window)
  end)
end

return M

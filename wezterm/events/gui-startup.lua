local wezterm = require("wezterm")
local mux = wezterm.mux

local M = {}

function M.setup()
  -- Maximize on startup
  wezterm.on("gui-startup", function(cmd)
    local _, _, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
  end)
end

return M

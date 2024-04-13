local Wezterm = require("wezterm")
local mux = Wezterm.mux

local M = {}

function M.setup()
  -- Maximize on startup
  Wezterm.on("gui-startup", function(cmd)
    local _, _, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
  end)
end

return M

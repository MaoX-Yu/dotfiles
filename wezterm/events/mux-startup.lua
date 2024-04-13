local Wezterm = require("wezterm")
local mux = Wezterm.mux

local M = {}

function M.setup()
  Wezterm.on("mux-startup", function(cmd)
    local _, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():set_inner_size(1280, 720)
    window:gui_window():set_position(980, 60)
    pane:split({ direction = "Bottom", size = 0.25 })
  end)
end

return M

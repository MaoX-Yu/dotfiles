local wezterm = require("wezterm")
local mux = wezterm.mux
local config = require("config")

local M = {}

-- Window geometry calibration (Maple Mono NF CN @ 14pt, 96 DPI):
--   cell width  = 11px (x_adv from ls-fonts)
--   cell height = (930 - 10 top padding) / 34 rows = 920 / 34
--   frame       = 16px horizontal OS borders + 2x5px padding = 26
--                 8px vertical OS border + 10px top padding   = 18
-- Cell sizes scale linearly with effective_dpi / 96.
function M.setup()
  wezterm.on("gui-startup", function(cmd)
    local ok, screen = pcall(function()
      return wezterm.gui.screens().main
    end)
    if not ok or not screen then
      mux.spawn_window(cmd or {})
      return
    end

    local k = screen.effective_dpi / 96
    local outer_width = math.floor(config.cols * 11 * k) + 26
    local outer_height = math.floor(config.rows * (920 / 34) * k) + 18
    local x = math.max(0, math.floor((screen.width - outer_width) / 2))
    local y = math.max(0, math.floor((screen.height - outer_height) / 2))

    local opts = {}
    if cmd then
      for key, value in pairs(cmd) do
        opts[key] = value
      end
    end
    opts.position = { x = x, y = y, origin = "MainScreen" }

    mux.spawn_window(opts)
  end)
end

return M

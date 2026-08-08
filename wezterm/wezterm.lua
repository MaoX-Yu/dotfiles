local wezterm = require("wezterm")
local windows = require("platforms.windows")
local linux = require("platforms.linux")
local config = require("config")
local events = require("events")

local C = {}

if wezterm.config_builder then
  C = wezterm.config_builder()
end

-- For windows host custom configuration
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  windows.setup(C)
end

-- For linux host custom configuration
if wezterm.target_triple == "x86_64-unknown-linux-gnu" then
  linux.setup(C)
end

events["new-tab-button"].setup()
events["right-status"].setup()
events["tab-title"].setup()
events["window-resized"].setup()

config.setup(C)

return C

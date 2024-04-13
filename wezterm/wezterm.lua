local Wezterm = require("wezterm")
local Windows = require("platforms.windows")
local Linux = require("platforms.linux")
local Config = require("config")
local Events = require("events")

local C = {}

if Wezterm.config_builder then
  C = Wezterm.config_builder()
end

-- For windows host custom configuration
if Wezterm.target_triple == "x86_64-pc-windows-msvc" then
  Windows.setup(C)
end

-- For linux host custom configuration
if Wezterm.target_triple == "x86_64-unknown-linux-gnu" then
  Linux.setup(C)
end

Events["new-tab-button"].setup()
Events["right-status"].setup()
Events["tab-title"].setup()
Events["window-resized"].setup()

Config.setup(C)

return C

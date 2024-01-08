local Wezterm = require("wezterm")

local M = {}

-- M.SOLID_LEFT_TRIANGLE = Wezterm.nerdfonts.ple_upper_left_triangle
-- M.SOLID_RIGHT_TRIANGLE = Wezterm.nerdfonts.ple_lower_right_triangle
M.SOLID_LEFT_TRIANGLE = Wezterm.nerdfonts.ple_lower_left_triangle
M.SOLID_RIGHT_TRIANGLE = Wezterm.nerdfonts.ple_upper_right_triangle

M.nerdfonts = {
  bash = "",
  cargo = "󱘗",
  cmd = "",
  fish = "",
  git = "",
  gitui = "",
  go = "",
  lazygit = "",
  mysql = "",
  mysqld = "",
  nvim = "",
  powershell = "",
  pwsh = "",
  python = "",
  rustc = "󱘗",
  scoop = "",
  vim = "",
  zsh = "",
}

return M

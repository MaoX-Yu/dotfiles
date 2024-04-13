local Wezterm = require("wezterm")

local M = {}

function M.setup(config)
  local ssh_domains = Wezterm.default_ssh_domains() -- Load SSH Domains from ~/.ssh/config
  config.ssh_domains = ssh_domains

  config.prefer_egl = true

  -- Default shell
  config.default_prog = { "zsh" }

  config.launch_menu = {}
end

return M

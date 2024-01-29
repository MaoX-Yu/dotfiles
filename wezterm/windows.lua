local Wezterm = require("wezterm")

local M = {}

function M.setup(config)
  local wsl_domains = Wezterm.default_wsl_domains()
  local ssh_domains = Wezterm.default_ssh_domains() -- Load SSH Domains from ~/.ssh/config

  for _, domain in ipairs(wsl_domains) do
    domain.default_cwd = "~"
  end

  config.wsl_domains = wsl_domains
  config.ssh_domains = ssh_domains

  local SHELL = os.getenv("NUSHELL")
  config.default_prog = { SHELL .. "\\nu.exe" }

  -- Using latest features
  config.prefer_egl = true

  config.launch_menu = {
    { label = " NuShell", args = { "nu" } },
    { label = " PowerShell", args = { "pwsh" } },
    { label = " Cmd", args = { "cmd" } },
    {
      label = " Dotfiles",
      args = { "pwsh", "-NoExit", "-Command", "cd $HOME/dotfiles" },
    },
    {
      label = " WSL CWD",
      args = { "wsl" },
    },
    {
      label = " WSL HOME",
      args = { "wsl", "~" },
    },
  }
end

return M

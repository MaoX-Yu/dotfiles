# Nushell Config File

# Load default config
source default_config.nu

$env.config = ($env.config | upsert show_banner false)
$env.config = ($env.config | upsert edit_mode 'vi')
$env.config.shell_integration = ($env.config.shell_integration | upsert osc133 false)

# Themes
source catppuccin-macchiato.nu

{{#if (is_executable "starship")}}
use starship.nu
{{/if}}
{{#if (is_executable "zoxide")}}
source zoxide.nu
{{/if}}
{{#if (is_executable "yazi")}}
source yazi.nu
{{/if}}

alias vi = nvim
alias lg = lazygit
{{#if (is_executable "bat")}}
alias cat = bat --paging=never --theme "Catppuccin Macchiato"
{{/if}}

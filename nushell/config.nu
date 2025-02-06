# Nushell Config File

$env.config.show_banner = "short"
$env.config.edit_mode = "vi"
$env.config.cursor_shape.vi_insert = "block"
$env.config.cursor_shape.vi_normal = "underscore"
$env.config.shell_integration.osc133 = false

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

alias n = nvim
alias nf = nvim (fzf)
alias lg = lazygit
{{#if (is_executable "bat")}}
alias cat = bat --paging=never --theme "Catppuccin Macchiato"
{{/if}}

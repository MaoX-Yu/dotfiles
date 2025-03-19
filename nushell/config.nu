# Nushell Config File

$env.PROMPT_INDICATOR = {|| "" }
$env.PROMPT_INDICATOR_VI_INSERT = {|| "" }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| "" }
$env.PROMPT_MULTILINE_INDICATOR = {|| "" }

const NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts')
    ($nu.data-dir | path join 'completions')
    ($nu.default-config-dir | path join 'themes')
]

const NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins')
]

$env.FZF_DEFAULT_OPTS = '
--layout=reverse
--height=~50%
--border=rounded
--info=inline
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6
--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796'

load-env {
    'CONDA_NO_PROMPT': true
    'VISUAL': 'nvim'
    'EDITOR': 'nvim'
}

$env.config.show_banner = "short"
$env.config.edit_mode = "vi"
$env.config.cursor_shape.vi_insert = "block"
$env.config.cursor_shape.vi_normal = "underscore"
$env.config.shell_integration.osc133 = false

# Themes
source catppuccin-macchiato.nu

mkdir ($nu.data-dir | path join "vendor/autoload")

{{#if (is_executable "starship")}}
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
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

# Nushell Config File

const NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts')
    ($nu.data-dir | path join 'completions')
    ($nu.default-config-dir | path join 'themes')
]

const NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins')
]

$env.FZF_DEFAULT_OPTS = '
--style=full:rounded
--layout=reverse
--border=none
--cycle
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8
--color=selected-bg:#45475A
--color=border:#6C7086,label:#CDD6F4'

load-env {
    'VISUAL': 'nvim'
    'EDITOR': 'nvim'
}

$env.config.show_banner = "short"
$env.config.shell_integration.osc133 = false

$env.PROMPT_INDICATOR = ''
$env.PROMPT_MULTILINE_INDICATOR = ''

mkdir ($nu.data-dir | path join "vendor/autoload")

{{#if (is_executable "zoxide")}}
$env._ZO_FZF_OPTS = '
--exact
--no-sort
--bind=ctrl-z:ignore,btab:up,tab:down
--cycle
--keep-right
--exit-0
--style=minimal
--layout=reverse
--border=rounded
--info=inline
--height=~50%
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8
--color=selected-bg:#45475A
--color=border:#6C7086,label:#CDD6F4,gutter:#313244'
zoxide init nushell | save -f ($nu.data-dir | path join "vendor/autoload/zoxide.nu")

{{/if}}
{{#if (is_executable "yazi")}}
source yazi.nu

{{/if}}
alias n = nvim
alias vi = nvim
alias ni = nvim (fzf --preview 'bat --color=always --style=numbers,changes --line-range :500 {}' --preview-border rounded)
alias hi = hx (fzf --preview 'bat --color=always --style=numbers,changes --line-range :500 {}' --preview-border rounded)
alias g = git
alias lg = lazygit
{{#if (is_executable "bat")}}
alias cat = bat --paging=never --theme "Catppuccin Mocha"
{{/if}}

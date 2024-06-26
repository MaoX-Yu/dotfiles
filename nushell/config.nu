# Nushell Config File

$env.config = {
    show_banner: false # true or false to enable or disable the welcome banner at startup

    cursor_shape: {
        emacs: line # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (line is the default)
        vi_insert: block # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (block is the default)
        vi_normal: underscore # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (underscore is the default)
    }

    edit_mode: vi # emacs, vi
}

{{#if (is_executable "starship")}}
use ~/.cache/starship/init.nu
{{/if}}
{{#if (is_executable "zoxide")}}
source ~/.config/nushell/zoxide.nu
{{/if}}
{{#if (is_executable "yazi")}}
source ~/.config/nushell/yazi.nu
{{/if}}

alias vi = nvim
alias lg = lazygit
{{#if (is_executable "bat")}}
alias cat = bat --paging=never --theme "Catppuccin-macchiato"
{{/if}}
{{#if (is_executable "eza")}}
alias ls = eza --color always --icons -s type
alias ll = eza --color always --icons -s type -l
alias la = eza --color always --icons -s type -l -a
{{/if}}

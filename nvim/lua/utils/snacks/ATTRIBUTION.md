# snacks.nvim attribution

The source files in this directory are a trimmed and modified copy of selected
modules from [folke/snacks.nvim](https://github.com/folke/snacks.nvim).

- Upstream version: `2.31.0`
- Upstream commit: `882c996cf28183f4d63640de0b4c02ec886d01f2`
- License: Apache License 2.0, reproduced in [LICENSE](LICENSE)

## Local changes

- Renamed the internal API and module namespace to `utils.snacks`.
- Removed the global `Snacks` object, the Snacks picker, dashboard, custom
  notifier, profiler, scroll, image, explorer, and unrelated integrations.
- Renamed window filetypes, variables, highlight groups, namespaces, and
  autocmd groups with the `mao` prefix.
- Replaced the scratch picker with `vim.ui.select` and the scratch Lua runner
  with a small local runner.
- Kept notification delivery on Neovim's native `vim.notify`.
- Dropped compatibility branches for Neovim versions older than 0.12.

`animate/easing.lua` also retains its embedded BSD-licensed easing equations
notice from its upstream source.

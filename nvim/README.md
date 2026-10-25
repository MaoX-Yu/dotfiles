# My Neovim

> Personal Neovim configuration

## Required

- neovim >= 0.12

- ripgrep

- fd/fd-find

- make

- cc

- git

- lazygit

## Snacks-derived code

Selected `snacks.nvim` utilities are vendored under `lua/utils/snacks` so this
configuration does not load or manage the upstream plugin. The adapted source
is based on `folke/snacks.nvim` `v2.31.0`, commit
`882c996cf28183f4d63640de0b4c02ec886d01f2`, and is distributed under
Apache-2.0. See `lua/utils/snacks/ATTRIBUTION.md` and
`lua/utils/snacks/LICENSE` for provenance, local modifications, and the full
license text.

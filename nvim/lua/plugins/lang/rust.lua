return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "rust", "ron" },
    },
  },
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      completion = {
        crates = {
          enabled = true,
        },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },
  {
    "mrcjkb/rustaceanvim",
    version = "*",
    lazy = false,
  },
}

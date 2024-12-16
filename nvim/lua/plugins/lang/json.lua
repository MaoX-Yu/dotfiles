return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = { "jsonls" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "json5" },
    },
  },
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false,
  },
}

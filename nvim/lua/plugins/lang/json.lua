return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "jsonls" },
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

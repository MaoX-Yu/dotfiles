return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = { "gopls" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "go", "gomod", "gowork", "gosum" },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["go"] = { "goimports" },
      },
    },
  },
}

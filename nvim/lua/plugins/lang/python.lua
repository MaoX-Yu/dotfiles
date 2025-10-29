return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "basedpyright", "ruff" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "python" },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["python"] = { "ruff_format" },
      },
    },
  },
}

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = { "basedpyright", "ruff" },
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

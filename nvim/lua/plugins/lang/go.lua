if vim.env.NVIM_LSP_DISABLED and not vim.env.NVIM_LSP_GO then
  return {}
end

return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "gopls" },
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

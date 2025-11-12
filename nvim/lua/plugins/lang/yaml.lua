if vim.env.NVIM_LSP_DISABLED and not vim.env.NVIM_LSP_YAML then
  return
end

return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "yamlls" },
    },
  },
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false,
  },
}

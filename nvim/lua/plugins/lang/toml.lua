if vim.env.NVIM_LSP_DISABLED and not vim.env.NVIM_LSP_TOML then
  return
end

return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "taplo" },
    },
  },
}

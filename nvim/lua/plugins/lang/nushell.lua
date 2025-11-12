if vim.env.NVIM_LSP_DISABLED and not vim.env.NVIM_LSP_NUSHELL then
  return
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = { "nushell" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "nu" },
    },
  },
}

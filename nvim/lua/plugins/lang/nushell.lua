if vim.env.NVIM_LSP_DISABLED and not vim.env.NVIM_LSP_NUSHELL then
  return {}
end

require("nvim-treesitter").install({ "nu" })

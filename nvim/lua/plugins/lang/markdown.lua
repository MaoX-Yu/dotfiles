if vim.env.NVIM_LSP_DISABLED and not vim.env.NVIM_LSP_MARKDOWN then
  return {}
end

require("nvim-treesitter").install({ "markdown", "markdown_inline" })

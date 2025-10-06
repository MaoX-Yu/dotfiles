return {
  {
    "neovim/nvim-lspconfig",
    cond = not vim.g.vscode,
    opts_extend = { "servers" },
    opts = {
      servers = {},
    },
    config = function(_, opts)
      vim.lsp.enable(opts.servers)
    end,
  },
}

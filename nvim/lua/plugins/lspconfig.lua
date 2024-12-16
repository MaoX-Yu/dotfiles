return {
  {
    "neovim/nvim-lspconfig",
    opts_extend = { "servers" },
    opts = {
      servers = { "lua_ls" },
    },
    config = function(_, opts)
      vim.lsp.enable(opts.servers)
      vim.diagnostic.config({
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
      })
    end,
  },
}

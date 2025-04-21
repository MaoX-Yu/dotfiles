return {
  {
    "neovim/nvim-lspconfig",
    cond = not vim.g.vscode,
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
      vim.diagnostic.handlers.loclist = {
        show = function()
          local winid = vim.api.nvim_get_current_win()
          vim.diagnostic.setloclist({ open = false })
          vim.api.nvim_set_current_win(winid)
        end,
      }
    end,
  },
}

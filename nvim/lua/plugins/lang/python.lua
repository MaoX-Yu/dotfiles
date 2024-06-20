if not LazyVim.has_extra("lang.python") then
  return {}
end

return {
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                typeCheckingMode = "basic",
              },
            },
          },
        },
      },
    },
  },
  {
    "williamboman/mason.nvim",
    optional = true,
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "debugpy")
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    optional = true,
    keys = {
      { "<leader>dP", "", desc = "Python", ft = "python" },
    },
  },
}

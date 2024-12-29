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
    opts = { ensure_installed = { "debugpy" } },
  },
  {
    "mfussenegger/nvim-dap-python",
    optional = true,
    keys = {
      { "<leader>dP", "", desc = "Python", ft = "python" },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        ["python"] = { "ruff_format" },
      },
    },
  },
}

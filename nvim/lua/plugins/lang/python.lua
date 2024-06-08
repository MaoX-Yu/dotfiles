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
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "debugpy")
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      local path = require("mason-registry").get_package("debugpy"):get_install_path()
      if LazyVim.is_win() then
        require("dap-python").setup(path .. "\\venv\\Scripts\\python.exe")
      else
        require("dap-python").setup(path .. "/venv/bin/python")
      end
    end,
  },
  {
    "linux-cultist/venv-selector.nvim",
    enabled = false,
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        ["<leader>dP"] = { name = "Python" },
      },
    },
  },
}

local util = require("utils")

if not util.check_extra("lang.python") then
  return {}
end

return {
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
      if util.is_windows() then
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
        ["<leader>dP"] = { name = "+python" },
      },
    },
  },
}

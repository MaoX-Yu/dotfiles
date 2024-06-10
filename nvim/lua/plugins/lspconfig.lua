return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "K", false }
      keys[#keys + 1] = { "<leader>ca", false }
    end,
    opts = {
      format = {
        timeout_ms = 3000,
      },
    },
  },
}

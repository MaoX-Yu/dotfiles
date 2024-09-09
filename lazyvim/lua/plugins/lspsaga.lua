return {
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({
        ui = {
          kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
        },
        symbol_in_winbar = {
          enable = false,
        },
        lightbulb = {
          enable = true,
          virtual_text = false,
        },
      })
      -- vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<cr>", { desc = "Hover" })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
}

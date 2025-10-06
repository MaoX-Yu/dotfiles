return {
  {
    "mason-org/mason.nvim",
    cond = not vim.g.vscode,
    cmd = {
      "Mason",
      "MasonUpdate",
      "MasonLog",
    },
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_uninstalled = "✗",
          package_pending = "⟳",
        },
      },
    },
    keys = {
      { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    cond = not vim.g.vscode,
    event = { "BufReadPre", "BufNewFile" },
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = { "emmylua_ls" },
    },
  },
}

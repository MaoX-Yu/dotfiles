return {
  {
    "williamboman/mason.nvim",
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
}

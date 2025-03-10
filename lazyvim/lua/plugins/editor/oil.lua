return {
  {
    "stevearc/oil.nvim",
    cond = not vim.g.vscode,
    event = "VeryLazy",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      keymaps = {
        ["q"] = "actions.close",
        ["<C-c>"] = false,
      },
    },
  },
}

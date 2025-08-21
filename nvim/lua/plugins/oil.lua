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
    keys = {
      {
        "<leader>e",
        function()
          require("oil").open_float()
        end,
        desc = "Open oil",
      },
      {
        "<leader>E",
        function()
          require("oil").open_float(vim.fn.getcwd())
        end,
        desc = "Open oil (cwd)",
      },
    },
  },
}

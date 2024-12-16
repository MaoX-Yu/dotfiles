return {
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      keymaps = {
        ["q"] = "actions.close",
        ["<C-c>"] = false,
      },
    },
    event = "VeryLazy",
    keys = {
      {
        "<leader>e",
        function()
          require("oil").open_float()
        end,
        desc = "Open Directory",
      },
      {
        "<leader>E",
        function()
          require("oil").open_float(vim.fn.getcwd())
        end,
        desc = "Open Directory (cwd)",
      },
    },
    dependencies = { "echasnovski/mini.icons" },
  },
}

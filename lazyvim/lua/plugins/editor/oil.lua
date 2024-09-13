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
        "<cmd>Oil<cr>",
        desc = "Open Directory",
      },
      {
        "<leader>E",
        function()
          require("oil").open(vim.fn.getcwd())
        end,
        desc = "Open Directory (cwd)",
      },
      {
        "<leader>fe",
        function()
          require("oil").open_float(vim.fn.expand("%:p:h"))
        end,
        desc = "Open Directory (Float)",
      },
    },
    dependencies = { "echasnovski/mini.icons" },
  },
}

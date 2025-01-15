return {
  {
    "stevearc/oil.nvim",
    lazy = false,
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      keymaps = {
        ["q"] = "actions.close",
        ["<C-c>"] = false,
      },
    },
    keys = function()
      if vim.fn.executable("yazi") == 1 then
        return
      end
      return {
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
      }
    end,
    dependencies = { "echasnovski/mini.icons" },
  },
}

return {
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
      { "<leader>U", "<cmd>UndotreeToggle<cr>", desc = "Undo Tree" },
    },
    init = function()
      vim.g.undotree_WindowLayout = 4
    end,
  },
  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      opts.right = opts.right or {}
      opts.bottom = opts.bottom or {}
      table.insert(opts.right, {
        title = "Undo Tree",
        ft = "undotree",
        open = "UndotreeToggle",
      })
      table.insert(opts.bottom, {
        title = "Diff",
        ft = "diff",
        open = "UndotreeToggle",
      })
    end,
  },
}

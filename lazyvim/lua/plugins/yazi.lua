if vim.fn.executable("yazi") == 0 then
  return {}
end

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },
  {
    "mikavilpas/yazi.nvim",
    keys = {
      {
        "<leader>e",
        "<cmd>Yazi<cr>",
        desc = "Open File Manager",
      },
      {
        "<leader>E",
        "<cmd>Yazi cwd<cr>",
        desc = "Open File Manager (cwd)",
      },
      {
        "<leader>fe",
        "<cmd>Yazi toggle<cr>",
        desc = "Resume Last Yazi Session",
      },
    },
    opts = function()
      local factor = vim.g.neovide and 0.97 or 1
      return {
        floating_window_scaling_factor = factor,
      }
    end,
  },
}

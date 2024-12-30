return {
  {
    "Daydreamer-riri/yazi.nvim",
    enabled = vim.fn.executable("yazi") == 1,
    event = "VeryLazy",
    keys = {
      {
        "<leader>e",
        "<cmd>Yazi<cr>",
        desc = "Open Yazi",
      },
      {
        "<leader>E",
        "<cmd>Yazi cwd<cr>",
        desc = "Open Yazi (cwd)",
      },
    },
    opts = {},
  },
}

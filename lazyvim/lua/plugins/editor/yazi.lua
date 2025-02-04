return {
  {
    "Daydreamer-riri/yazi.nvim",
    enabled = vim.fn.executable("yazi") == 1,
    event = "VeryLazy",
    cmd = { "Yazi" },
    opts = {},
  },
}

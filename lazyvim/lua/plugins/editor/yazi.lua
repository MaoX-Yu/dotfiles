return {
  {
    "Daydreamer-riri/yazi.nvim",
    enabled = vim.fn.executable("yazi") == 1,
    cond = not vim.g.vscode,
    event = "VeryLazy",
    cmd = { "Yazi" },
    opts = {},
  },
}

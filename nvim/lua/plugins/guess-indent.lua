return {
  {
    "nmac427/guess-indent.nvim",
    cond = not vim.g.vscode,
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
}

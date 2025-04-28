return {
  {
    "folke/todo-comments.nvim",
    cond = not vim.g.vscode,
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TodoQuickFix", "TodoLocList" },
    opts = {},
  },
}

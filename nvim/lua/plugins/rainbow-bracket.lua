return {
  {
    "HiPhish/rainbow-delimiters.nvim",
    cond = not vim.g.vscode,
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    main = "rainbow-delimiters.setup",
  },
}

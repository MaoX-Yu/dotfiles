return {
  {
    "HiPhish/rainbow-delimiters.nvim",
    cond = not vim.g.vscode,
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "LazyFile",
    main = "rainbow-delimiters.setup",
  },
}

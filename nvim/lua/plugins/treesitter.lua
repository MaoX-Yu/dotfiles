return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    lazy = vim.fn.argc(-1) == 0,
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    opts_extend = { "ensure_installed" },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "query",
        "regex",
        "toml",
        "vim",
        "vimdoc",
        "yaml",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<M-o>",
          node_incremental = "<M-o>",
          scope_incremental = false,
          node_decremental = "<M-i>",
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<BS>", "<M-i>", desc = "Decrement Selection", mode = "x", remap = true },
        { "<c-space>", "<M-o>", desc = "Increment Selection", mode = { "x", "n" }, remap = true },
        { "<M-i>", desc = "Decrement Selection", mode = "x" },
        { "<M-o>", desc = "Increment Selection", mode = { "x", "n" } },
      },
    },
  },
}

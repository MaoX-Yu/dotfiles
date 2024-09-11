return {
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      opts.incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<M-o>",
          node_incremental = "<M-o>",
          scope_incremental = false,
          node_decremental = "<M-i>",
        },
      }
      return opts
    end,
  },
  {
    "folke/which-key.nvim",
    optional = true,
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

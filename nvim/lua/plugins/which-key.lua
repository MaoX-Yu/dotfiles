return {
  {
    "folke/which-key.nvim",
    cond = not vim.g.vscode,
    event = "VeryLazy",
    opts_extend = { "spec" },
    opts = {
      preset = "helix",
      win = {
        no_overlap = false,
      },
      expand = function(node)
        return not node.desc -- expand all nodes without a description
      end,
      icons = {
        separator = "│",
        group = "",
        mappings = false,
        keys = {
          BS = "󰁮 ",
        },
      },
      show_help = false,
      spec = {
        { "f", desc = "Find next char" },
        { "F", desc = "Find prev char" },
        { "t", desc = "Find next char before" },
        { "T", desc = "Find prev char before" },
        { ";", desc = "Next find result" },
        { ",", desc = "Prev find result" },
        { "]d", desc = "Next diagnostic" },
        { "[d", desc = "Previous diagnostic" },
        { "]D", desc = "Last diagnostic" },
        { "[D", desc = "First diagnostic" },
        { "<", group = "indent left" },
        { ">", group = "indent right" },
        { "<leader>", group = "leader" },
        { "<leader>o", group = "overseer" },
        { "<BS>", "<M-i>", desc = "Decrement selection", mode = "x", remap = true },
        { "<c-space>", "<M-o>", desc = "Increment selection", mode = { "x", "n" }, remap = true },
        { "<M-i>", desc = "Decrement selection", mode = "x" },
        { "<M-o>", desc = "Increment selection", mode = { "x", "n" } },
        {
          mode = { "n", "v" },
          { "[", group = "prev" },
          { "]", group = "next" },
          { "g", group = "goto" },
          { "gz", group = "surround" },
          { "z", group = "fold" },
          { "<leader><tab>", group = "tabs" },
          { "<leader>A", group = "avante" },
          { "<leader>c", group = "code" },
          { "<leader>g", group = "git" },
          { "<leader>s", group = "search" },
          { "<leader>u", group = "ui" },
          { "<leader>x", group = "quickfix" },
          {
            "<leader>b",
            group = "buffer",
            expand = function()
              return require("which-key.extras").expand.buf()
            end,
          },
          {
            "<leader>w",
            group = "windows",
            proxy = "<c-w>",
            expand = function()
              return require("which-key.extras").expand.win()
            end,
          },
          { "gx", desc = "Open with system app" },
          { "<C-_>", hidden = true },
        },
      },
    },
  },
}

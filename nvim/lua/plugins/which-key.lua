return {
  {
    "folke/which-key.nvim",
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
        { "f", desc = "Find Next Char" },
        { "F", desc = "Find Prev Char" },
        { "t", desc = "Find Next Char Before" },
        { "T", desc = "Find Prev Char Before" },
        { ";", desc = "Next Find Result" },
        { ",", desc = "Prev Find Result" },
        { "]d", desc = "Next Diagnostic" },
        { "[d", desc = "Previous Diagnostic" },
        { "]D", desc = "Last Diagnostic" },
        { "[D", desc = "First Diagnostic" },
        { "<", group = "indent left" },
        { ">", group = "indent right" },
        { "<leader>", group = "leader" },
        {
          mode = { "n", "v" },
          { "<leader><tab>", group = "tabs" },
          { "<leader>a", group = "avante" },
          { "<leader>c", group = "code" },
          { "<leader>g", group = "git" },
          { "<leader>s", group = "search" },
          { "<leader>u", group = "ui" },
          { "<leader>x", group = "quickfix" },
          { "[", group = "prev" },
          { "]", group = "next" },
          { "g", group = "goto" },
          { "gs", group = "surround" },
          { "z", group = "fold" },
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

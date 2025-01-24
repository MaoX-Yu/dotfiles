return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      preset = "helix",
      win = {
        no_overlap = false,
        height = { min = 4, max = 999 },
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
        { "=", group = "filter" },
        { "<", group = "indent left" },
        { ">", group = "indent right" },
        { "f", desc = "Find Next Char" },
        { "F", desc = "Find Prev Char" },
        { "t", desc = "Find Next Char Before" },
        { "T", desc = "Find Prev Char Before" },
        { ";", desc = "Next Find Result" },
        { ",", desc = "Prev Find Result" },
        { "<leader>", group = "leader" },
        { "<leader>rn", desc = "Rename Symbol" },
        {
          mode = { "n", "v" },
          { "<C-_>", hidden = true },
        },
      },
    },
  },
}

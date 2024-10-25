return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      preset = "helix",
      win = {
        height = { min = 4, max = 999 },
      },
      expand = function(node)
        return not node.desc -- expand all nodes without a description
      end,
      icons = {
        group = "",
        mappings = false,
        keys = {
          BS = "󰁮 ",
        },
      },
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
        { "<leader>S", group = "session" },
        { "<leader>o", group = "overseer" },
        { "<leader>r", group = "refactor" },
        { "<leader>K", desc = "Keywordprg" },
        { "<leader>q", desc = "Quit All" },
        { "<leader>rn", desc = "Rename Symbol" },
        { "<leader>%", desc = "Select All" },
        {
          mode = { "n", "v" },
          { "<C-_>", hidden = true },
        },
      },
    },
  },
}

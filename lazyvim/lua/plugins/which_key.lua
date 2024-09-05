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
        rules = {
          { plugin = "dropbar.nvim", icon = " ", color = "green" },
          { plugin = "overseer.nvim", icon = " ", color = "yellow" },
          { plugin = "undotree", icon = " ", color = "green" },
        },
        keys = {
          BS = "󰁮 ",
        },
      },
      spec = {
        { "=", group = "apply filter" },
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
        { "<leader>o", group = "overseer", icon = { icon = " ", color = "yellow" } },
        { "<leader>r", group = "refactor", icon = { icon = " ", color = "purple" } },
        { "<leader>K", desc = "Keywordprg", icon = { icon = "󰘥 ", color = "green" } },
        { "<leader>q", desc = "Quit All" },
        { "<leader>rn", desc = "Rename Symbol", icon = { icon = "󰑕 ", color = "purple" } },
        { "<leader>%", desc = "Select All", icon = { icon = "󰒆 ", color = "yellow" } },
        {
          mode = { "n", "v" },
          { "<C-_>", hidden = true },
        },
      },
    },
  },
}

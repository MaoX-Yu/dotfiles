return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      preset = "helix",
      win = {
        height = { min = 4, max = 999 },
      },
      icons = {
        group = "",
        rules = {
          { plugin = "dropbar.nvim", icon = " ", color = "green" },
          { plugin = "overseer.nvim", icon = " ", color = "yellow" },
        },
      },
      spec = {
        { "=", group = "apply filter" },
        { "<", group = "indent left" },
        { ">", group = "indent right" },
        { "<leader>", group = "leader" },
        { "<leader>S", group = "session" },
        { "<leader>o", group = "overseer", icon = { icon = " ", color = "yellow" } },
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

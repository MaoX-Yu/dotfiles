return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    optional = true,
    init = function() end,
    keys = function()
      return {
        {
          "<leader>e",
          function()
            require("neo-tree.command").execute({ toggle = true, dir = require("lazyvim.util").root.get() })
          end,
          desc = "Explorer NeoTree (Root Dir)",
        },
        {
          "<leader>E",
          function()
            require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
          end,
          desc = "Explorer NeoTree (cwd)",
        },
        { "<leader>fe", "<cmd>Neotree focus<cr>", desc = "Focus on NeoTree", remap = true },
        { "<leader>fE", "<cmd>Neotree reveal<cr>", desc = "Find File in NeoTree", remap = true },
      }
    end,
  },
}

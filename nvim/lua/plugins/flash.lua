local inc_selection = {
  actions = {
    ["<M-o>"] = "next",
    ["<M-i>"] = "prev",
  },
}

P:add({
  {
    src = "https://github.com/folke/flash.nvim",
    data = {
      config = function()
        require("flash").setup({
          modes = {
            char = {
              multi_line = false,
              highlight = { backdrop = false },
            },
            treesitter = {
              labels = "",
            },
          },
          prompt = {
            win_config = {
              border = "none",
            },
          },
        })

        -- stylua: ignore
        P.map({
          { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
          { "<M-o>", mode = { "n", "o", "x" }, function() require("flash").treesitter(inc_selection) end, desc = "Flash Treesitter" },
          { "r", mode = "o", function() require("flash").remote() end, desc = "Remote flash" },
          { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter search" },
          { "<C-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle flash search" },
        })
      end,
    },
  },
})

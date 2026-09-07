P:add({
  {
    src = "https://github.com/folke/persistence.nvim",
    data = {
      config = function()
        require("persistence").setup({})
      end,
    },
  },
})

-- stylua: ignore
P.map({
  { "<leader>Ss", function() require("persistence").load() end, desc = "Restore session for cwd" },
  { "<leader>SS", function() require("persistence").select() end, desc = "Select session" },
  { "<leader>Sl", function() require("persistence").load({ last = true }) end, desc = "Restore last session" },
  { "<leader>Sd", function() require("persistence").stop() end, desc = "Don't save session" },
})

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
  { "<Leader>Ss", function() require("persistence").load() end, desc = "Restore session for cwd" },
  { "<Leader>SS", function() require("persistence").select() end, desc = "Select session" },
  { "<Leader>Sl", function() require("persistence").load({ last = true }) end, desc = "Restore last session" },
  { "<Leader>Sd", function() require("persistence").stop() end, desc = "Don't save session" },
})

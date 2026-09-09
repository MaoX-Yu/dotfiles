P:add({
  {
    src = "https://github.com/NeogitOrg/neogit",
    cmd = { "Neogit" },
    data = {
      config = function()
        require("neogit").setup({
          signs = {
            hunk = { "", "" },
            item = { "", "" },
            section = { "", "" },
          },
        })
      end,
    },
  },
})

P.map({
  { "<Leader>gg", "<Cmd>Neogit<CR>", desc = "Neogit" },
})

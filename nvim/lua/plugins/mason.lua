P:add({
  {
    src = "https://github.com/mason-org/mason.nvim",
    data = {
      cmd = {
        "Mason",
        "MasonUpdate",
        "MasonLog",
      },
      event = { "BufReadPre", "BufNewFile" },
      config = function()
        require("mason").setup({
          ui = {
            icons = {
              package_installed = "✓",
              package_uninstalled = "✗",
              package_pending = "⟳",
            },
          },
        })
      end,
    },
  },
})

P.map({
  { "<Leader>cm", "<Cmd>Mason<CR>", desc = "Mason" },
})

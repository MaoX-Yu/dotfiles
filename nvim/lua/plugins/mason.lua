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
        ---@diagnostic disable-next-line: missing-fields
        require("mason").setup({
          ui = {
            icons = {
              package_installed = "✓",
              package_uninstalled = "✗",
              package_pending = "⟳",
            },
          },
        } --[[@as MasonSettings]])

        P.map({
          { "<Leader>cm", "<Cmd>Mason<CR>", desc = "Mason" },
        })
      end,
    },
  },
})

P:add({
  "https://github.com/mrcjkb/rustaceanvim",
  {
    src = "https://github.com/Saecki/crates.nvim",
    data = {
      event = { "BufRead Cargo.toml" },
      config = function()
        require("crates").setup({
          completion = {
            crates = {
              enabled = true,
            },
          },
          lsp = {
            enabled = true,
            actions = true,
            completion = true,
            hover = true,
          },
        })
      end,
    },
  },
})

return {
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  {
    "rafamadriz/friendly-snippets",
    lazy = true,
    opts = function()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
    end,
  },
  {
    "garymjr/nvim-snippets",
    lazy = true,
    opts = {
      friendly_snippets = false,
    },
  },
}

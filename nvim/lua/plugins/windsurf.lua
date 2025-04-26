return {
  {
    "Exafunction/windsurf.nvim",
    cond = not vim.g.vscode,
    event = "InsertEnter",
    cmd = "Codeium",
    opts = {},
    config = function(_, opts)
      require("codeium").setup(opts)
    end,
  },
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        default = { "codeium" },
        providers = {
          codeium = {
            name = "codeium",
            module = "blink.compat.source",
            async = true,
            score_offset = 100,
            transform_items = function(_, items)
              for _, item in ipairs(items) do
                item.kind_icon = "󰘦 "
                item.kind_hl = "BlinkCmpKindCodeium"
              end
              return items
            end,
          },
        },
      },
    },
  },
}

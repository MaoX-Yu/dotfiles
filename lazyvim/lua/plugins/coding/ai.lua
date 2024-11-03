if LazyVim.has_extra("coding.codeium") then
  return {}
end

return {
  {
    "luozhiya/fittencode.nvim",
    event = "InsertEnter",
    opts = {
      completion_mode = "source",
    },
  },
  {
    "iguanacucumber/magazine.nvim",
    name = "nvim-cmp",
    optional = true,
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend({ { name = "fittencode", group_index = 1 } }, opts.sources))
      return opts
    end,
  },
  {
    "Saghen/blink.cmp",
    optional = true,
    opts = {
      sources = {
        completion = {
          enabled_providers = { "fittencode" },
        },
        providers = {
          fittencode = {
            name = "fittencode",
            module = "blink.compat.source",
            score_offset = 99,
            opts = {},
          },
        },
      },
    },
  },
}

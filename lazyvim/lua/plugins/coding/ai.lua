if LazyVim.has_extra("ai.codeium") then
  return {}
end

return {
  {
    "luozhiya/fittencode.nvim",
    event = "InsertEnter",
    opts = {
      completion_mode = "source",
      source_completion = {
        engine = LazyVim.has_extra("coding.blink") and "blink" or "cmp",
      },
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
    "saghen/blink.cmp",
    optional = true,
    opts = {
      sources = {
        completion = {
          enabled_providers = { "fittencode" },
        },
        providers = {
          fittencode = {
            name = "fittencode",
            module = "fittencode.sources.blink",
            score_offset = 15,
          },
        },
      },
    },
  },
}

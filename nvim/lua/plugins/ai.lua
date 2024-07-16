if LazyVim.has_extra("coding.codeium") then
  return {}
end

return {
  {
    "luozhiya/fittencode.nvim",
    opts = {
      completion_mode = "source",
    },
    dependencies = {
      {
        "hrsh7th/nvim-cmp",
        ---@param opts cmp.ConfigSchema
        opts = function(_, opts)
          local cmp = require("cmp")
          opts.sources = cmp.config.sources(vim.list_extend({ { name = "fittencode", group_index = 1 } }, opts.sources))
          return opts
        end,
      },
    },
  },
}

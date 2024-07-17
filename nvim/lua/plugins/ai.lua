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
    "hrsh7th/nvim-cmp",
    optional = true,
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend({ { name = "fittencode", group_index = 1 } }, opts.sources))
      return opts
    end,
  },
}

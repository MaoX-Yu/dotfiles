return {
  {
    "max397574/better-escape.nvim",
    event = "LazyFile",
    opts = {
      mappings = {
        t = {
          j = {
            k = function()
              if vim.bo.filetype == "yazi" then
                return "k"
              end
              return "<C-\\><C-n>"
            end,
          },
        },
      },
    },
  },
}

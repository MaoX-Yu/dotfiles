if not vim.fn.executable("yazi") then
  return {}
end

return {
  {
    "mikavilpas/yazi.nvim",
    keys = {
      {
        "<leader>y",
        function()
          require("yazi").yazi()
        end,
        desc = "Open File Manager",
      },
      {
        "<leader>Y",
        function()
          require("yazi").yazi(nil, vim.fn.getcwd())
        end,
        desc = "Open File Manager (cwd)",
      },
    },
    opts = {},
  },
}

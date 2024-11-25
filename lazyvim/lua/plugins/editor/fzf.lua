if not LazyVim.has_extra("editor.fzf") then
  return {}
end

return {
  {
    "ibhagwan/fzf-lua",
    optional = true,
    keys = {
      { "<leader>,", false },
      { '<leader>s"', false },
      { "<leader>sa", false },
      { "<leader>sb", false },
      { "<leader>sc", false },
      { "<leader>sC", false },
      { "<leader>sd", false },
      { "<leader>sD", false },
      { "<leader>sg", false },
      { "<leader>sG", false },
      { "<leader>sh", false },
      { "<leader>sH", false },
      { "<leader>sj", false },
      { "<leader>sk", false },
      { "<leader>sl", false },
      { "<leader>sM", false },
      { "<leader>sm", false },
      { "<leader>sR", false },
      { "<leader>sq", false },
      { "<leader>sw", false },
      { "<leader>sW", false },
      { "<leader>sw", false },
      { "<leader>sW", false },
      { "<leader>ss", false },
      { "<leader>sS", false },
      { "<leader>s", "<cmd>FzfLua builtin<cr>", desc = "Search by Fzf" },
    },
  },
  {
    "folke/todo-comments.nvim",
    optional = true,
    keys = {
      { "<leader>st", false },
      { "<leader>sT", false },
      { "<leader>xs", "", desc = "search" },
      {
        "<leader>xst",
        function()
          require("todo-comments.fzf").todo()
        end,
        desc = "Todo",
      },
      {
        "<leader>xsT",
        function()
          require("todo-comments.fzf").todo({ keywords = { "TODO", "FIX", "FIXME" } })
        end,
        desc = "Todo/Fix/Fixme",
      },
    },
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>s", desc = "Search by Fzf" },
      },
    },
  },
}

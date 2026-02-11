P:add({
  {
    src = "https://github.com/mfussenegger/nvim-dap-python",
    data = {
      ft = { "python" },
      config = function()
        require("dap-python").setup("debugpy-adapter")
      end,
    },
  },
})

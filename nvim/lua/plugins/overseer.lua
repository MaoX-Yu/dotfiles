P:add({
  {
    src = "https://github.com/stevearc/overseer.nvim",
    data = {
      cmd = {
        "OverseerOpen",
        "OverseerClose",
        "OverseerToggle",
        "OverseerRun",
        "OverseerShell",
        "OverseerTaskAction",
      },
      event = { "BufReadPost", "BufNewFile" },
      config = function()
        require("overseer").setup({
          dap = true,
          task_list = {
            direction = "right",
          },
        })

        P.map({
          { "<Leader>ow", "<Cmd>OverseerToggle<CR>", desc = "Toggle task list" },
          { "<Leader>oo", "<Cmd>OverseerRun<CR>", desc = "Run task" },
          { "<Leader>ot", "<Cmd>OverseerTaskAction<CR>", desc = "Task action" },
          { "<Leader>os", "<Cmd>OverseerShell<CR>", desc = "Run shell" },
        })
      end,
    },
  },
})

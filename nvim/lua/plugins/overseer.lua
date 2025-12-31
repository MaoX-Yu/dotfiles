return {
  {
    "stevearc/overseer.nvim",
    cond = not vim.g.vscode,
    cmd = {
      "OverseerOpen",
      "OverseerClose",
      "OverseerToggle",
      "OverseerRun",
      "OverseerShell",
      "OverseerTaskAction",
    },
    opts = {
      dap = true,
      task_list = {
        direction = "right",
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>ow", "<cmd>OverseerToggle<cr>",     desc = "Toggle task list" },
      { "<leader>oo", "<cmd>OverseerRun<cr>",        desc = "Run task" },
      { "<leader>ot", "<cmd>OverseerTaskAction<cr>", desc = "Task action" },
      { "<leader>os", "<cmd>OverseerShell<cr>",      desc = "Run shell" },
    },
  },
}

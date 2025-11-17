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
      templates = { "builtin", "python" },
      task_list = {
        bindings = {
          ["<C-h>"] = false,
          ["<C-j>"] = false,
          ["<C-k>"] = false,
          ["<C-l>"] = false,
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>ow", "<cmd>OverseerToggle<cr>",     desc = "Toggle task list" },
      { "<leader>oo", "<cmd>OverseerOpen<cr>",       desc = "Open task list" },
      { "<leader>oc", "<cmd>OverseerClose<cr>",      desc = "Close task list" },
      { "<leader>ot", "<cmd>OverseerTaskAction<cr>", desc = "Task action" },
      { "<leader>os", "<cmd>OverseerShell<cr>",      desc = "Run shell" },
    },
  },
}

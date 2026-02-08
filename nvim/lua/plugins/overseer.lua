local utils = require("utils") ---@as MaoUtils
local lazy = utils.pack.lazy
local map = utils.pack.map

vim.pack.add({
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
      config = function()
        require("overseer").setup({
          dap = true,
          task_list = {
            direction = "right",
          },
        })

        map({
          { "<Leader>ow", "<Cmd>OverseerToggle<CR>", desc = "Toggle task list" },
          { "<Leader>oo", "<Cmd>OverseerRun<CR>", desc = "Run task" },
          { "<Leader>ot", "<Cmd>OverseerTaskAction<CR>", desc = "Task action" },
          { "<Leader>os", "<Cmd>OverseerShell<CR>", desc = "Run shell" },
        })
      end,
    },
  },
}, {
  load = lazy,
})

return {
  {
    "folke/snacks.nvim",
    cond = not vim.g.vscode,
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      dashboard = {
        enabled = true,
        preset = {
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":enew" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "p", desc = "Projects", action = ":lua Snacks.picker.projects()" },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
      indent = {
        chunk = {
          enabled = true,
          hl = {
            "RainbowRed",
            "RainbowYellow",
            "RainbowBlue",
            "RainbowOrange",
            "RainbowGreen",
            "RainbowViolet",
            "RainbowCyan",
          },
        },
      },
      input = { enabled = true },
      notifier = { enabled = true },
      picker = {
        enabled = true,
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "n", "i" } },
            },
          },
        },
      },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      styles = {
        notification = {
          wo = { wrap = true }, -- Wrap notifications
        },
        notification_history = {
          width = 0.8,
          height = 0.8,
        },
      },
    },
    -- stylua: ignore
    keys = {
      -- Top Pickers & Explorer
      { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart find files" },
      { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command history" },
      { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification history" },
      -- find
      { "<leader>f", function() Snacks.picker.files() end, desc = "Find files" },
      -- git
      { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git branches" },
      { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git browse", mode = { "n", "v" } },
      { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git diff (Hunks)" },
      { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git log file" },
      { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
      { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git log" },
      { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git log line" },
      { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git status" },
      { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git stash" },
      -- Grep
      { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer lines" },
      { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep open buffers" },
      { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
      -- search
      { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
      { '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search history" },
      { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
      { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer lines" },
      { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command history" },
      { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
      { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
      { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer diagnostics" },
      { "<leader>sh", function() Snacks.picker.help() end, desc = "Help pages" },
      { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
      { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
      { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
      { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
      { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location list" },
      { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
      { "<leader>sM", function() Snacks.picker.man() end, desc = "Man pages" },
      { "<leader>sp", function() Snacks.picker.projects() end, desc = "Projects" },
      { "<leader>sP", function() Snacks.picker.lazy() end, desc = "Search for plugin spec" },
      { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix list" },
      { "<leader>sr", function() Snacks.picker.recent() end, desc = "Recent" },
      { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
      { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo history" },
      { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
      -- LSP
      { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto definition" },
      { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto declaration" },
      { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "Goto references" },
      { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto implementation" },
      { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto type definition" },
      { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP symbols" },
      { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP workspace symbols" },
      -- Other
      { "<leader>z",  function() Snacks.zen() end, desc = "Toggle zen mode" },
      { "<leader>Z",  function() Snacks.zen.zoom() end, desc = "Toggle zoom" },
      { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle scratch buffer" },
      { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select scratch buffer" },
      { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification history" },
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete buffer" },
      { "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete other buffers" },
      { "<leader>cr", function() Snacks.rename.rename_file() end, desc = "Rename file" },
      { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss all notifications" },
      { "<leader>t",  function() Snacks.terminal() end, desc = "Toggle terminal" },
      { "]r",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next reference", mode = { "n", "t" } },
      { "[r",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev reference", mode = { "n", "t" } },
      {
        "<leader>N",
        desc = "Neovim news",
        function()
          Snacks.win({
            file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
            width = 0.6,
            height = 0.6,
            wo = {
              spell = false,
              wrap = false,
              signcolumn = "yes",
              statuscolumn = " ",
              conceallevel = 3,
            },
          })
        end,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Create some toggle mappings
          Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
          Snacks.toggle.diagnostics():map("<leader>ud")
          Snacks.toggle.line_number():map("<leader>ul")
          Snacks.toggle
            .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
            :map("<leader>uc")
          Snacks.toggle.treesitter():map("<leader>uT")
          Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
          Snacks.toggle.inlay_hints():map("<leader>uh")
          Snacks.toggle.indent():map("<leader>ug")
          Snacks.toggle.dim():map("<leader>uD")
          Snacks.toggle({
            name = "Auto Format (Global)",
            get = function()
              return vim.g.autoformat
            end,
            set = function(state)
              vim.g.autoformat = not state
            end,
          }):map("<leader>uf")
          Snacks.toggle({
            name = "Auto Format (Buffer)",
            get = function()
              return vim.b.autoformat == nil and true or vim.b.autoformat
            end,
            set = function(state)
              vim.b.autoformat = state
            end,
          }):map("<leader>uF")
          Snacks.toggle({
            name = "Virtual Lines",
            get = function()
              return type(vim.diagnostic.config().virtual_lines) == "table"
            end,
            set = function(state)
              if state then
                vim.diagnostic.config({
                  virtual_lines = { current_line = true },
                  virtual_text = { current_line = false },
                })
              else
                vim.diagnostic.config({
                  virtual_lines = false,
                  virtual_text = { current_line = nil },
                })
              end
            end,
          }):map("<leader>uv")
        end,
      })
    end,
  },
}

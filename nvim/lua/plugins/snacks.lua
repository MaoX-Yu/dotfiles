local utils = require("utils") ---@as MaoUtils
local lazy = utils.pack.lazy
local map = utils.pack.map

vim.pack.add({
  {
    src = "https://github.com/folke/snacks.nvim",
    data = {
      config = function()
        require("snacks").setup({
          bigfile = { enabled = true },
          dashboard = {
            enabled = true,
            preset = {
              header = [[
                                                                   
      ████ ██████           █████      ██                    
     ███████████             █████                            
     █████████ ███████████████████ ███   ███████████  
    █████████  ███    █████████████ █████ ██████████████  
   █████████ ██████████ █████████ █████ █████ ████ █████  
 ███████████ ███    ███ █████████ █████ █████ ████ █████ 
██████  █████████████████████ ████ █████ █████ ████ ██████]],
              keys = {
                { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                { icon = " ", key = "n", desc = "New File", action = ":enew" },
                {
                  icon = " ",
                  key = "s",
                  desc = "Restore Session",
                  action = ":lua require('persistence').load({ last = true })",
                },
                { icon = " ", key = "l", desc = "Pack", action = ":lua vim.pack.update()" },
                { icon = " ", key = "q", desc = "Quit", action = ":qa" },
              },
            },
            sections = {
              { section = "header" },
              { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
              { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
              { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
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
          picker = { enabled = true },
          quickfile = { enabled = true },
          scope = { enabled = true },
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
        } --[[@as snacks.Config]])

        vim.api.nvim_create_autocmd("User", {
          callback = function()
            -- Create some toggle mappings
            Snacks.toggle.option("spell", { name = "Spelling" }):map("<Leader>us")
            Snacks.toggle.option("wrap", { name = "Wrap" }):map("<Leader>uw")
            Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<Leader>uL")
            Snacks.toggle.diagnostics():map("<Leader>ud")
            Snacks.toggle.line_number():map("<Leader>ul")
            Snacks.toggle
              .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
              :map("<Leader>uc")
            Snacks.toggle.treesitter():map("<Leader>uT")
            Snacks.toggle
              .option("background", { off = "light", on = "dark", name = "Dark Background" })
              :map("<Leader>ub")
            Snacks.toggle.inlay_hints():map("<Leader>uh")
            Snacks.toggle.indent():map("<Leader>ug")
            Snacks.toggle.dim():map("<Leader>uD")
            Snacks.toggle({
              name = "Auto Format (Global)",
              get = function()
                return vim.g.autoformat
              end,
              set = function(state)
                vim.g.autoformat = state
              end,
            }):map("<Leader>uf")
            Snacks.toggle({
              name = "Auto Format (Buffer)",
              get = function()
                return vim.b.autoformat == nil and true or vim.b.autoformat
              end,
              set = function(state)
                vim.b.autoformat = state
              end,
            }):map("<Leader>uF")
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
            }):map("<Leader>uv")
          end,
        })

        -- stylua: ignore
        map({
          -- Top Pickers & Explorer
          { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart find files" },
          { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
          { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
          { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command history" },
          -- find
          { "<leader>f", function() Snacks.picker.files() end, desc = "Find files" },
          -- git
          { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git branches" },
          -- Git
          { "<Leader>gB", function() Snacks.gitbrowse() end, desc = "Git browse", mode = { "n", "v" } },
          { "<Leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
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
          { "<leader>sd", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer diagnostics" },
          { "<leader>sD", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
          { "<leader>sh", function() Snacks.picker.help() end, desc = "Help pages" },
          { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
          { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
          { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
          { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
          { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location list" },
          { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
          { "<leader>sM", function() Snacks.picker.man() end, desc = "Man pages" },
          { "<leader>sp", function() Snacks.picker.projects() end, desc = "Projects" },
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
          { "<Leader>z",  function() Snacks.zen.zen() end, desc = "Toggle zen mode" },
          { "<Leader>Z",  function() Snacks.zen.zoom() end, desc = "Toggle zoom" },
          { "<Leader>.",  function() Snacks.scratch() end, desc = "Toggle scratch buffer" },
          { "<Leader>S",  function() Snacks.scratch.select() end, desc = "Select scratch buffer" },
          { "<Leader>bc", function() Snacks.bufdelete() end, desc = "Close buffer" },
          { "<Leader>bo", function() Snacks.bufdelete.other() end, desc = "Close other buffers" },
          { "<Leader>cr", function() Snacks.rename.rename_file() end, desc = "Rename file" },
          { "<Leader>t",  function() Snacks.terminal() end, desc = "Toggle terminal" },
          { "]w",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next word", mode = { "n", "t" } },
          { "[w",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev word", mode = { "n", "t" } },
        })
      end,
    },
  },
}, {
  load = lazy,
})

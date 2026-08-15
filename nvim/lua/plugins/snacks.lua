P:add({
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
                { icon = " ", key = "f", desc = "Find File", action = ":Telescope find_files" },
                { icon = " ", key = "n", desc = "New File", action = ":enew" },
                {
                  icon = " ",
                  key = "s",
                  desc = "Restore Session",
                  action = ":lua require('persistence').load({ last = true })",
                },
                { icon = " ", key = "l", desc = "Pack", action = ":lua vim.pack.update()" },
                { icon = " ", key = "q", desc = "Quit", action = ":q" },
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
        })

        ---@diagnostic disable: undefined-global
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
        P.map({
          -- Git
          { "<Leader>gB", function() Snacks.gitbrowse() end, desc = "Git browse", mode = { "n", "v" } },
          { "<Leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
          -- Other
          { "<Leader>z",  function() Snacks.zen.zen() end, desc = "Toggle zen mode" },
          { "<Leader>Z",  function() Snacks.zen.zoom() end, desc = "Toggle zoom" },
          { "<Leader>.",  function() Snacks.scratch() end, desc = "Toggle scratch buffer" },
          { "<Leader>S",  function() Snacks.scratch.select() end, desc = "Select scratch buffer" },
          { "<Leader>bc", function() Snacks.bufdelete() end, desc = "Close buffer" },
          { "<Leader>bo", function() Snacks.bufdelete.other() end, desc = "Close other buffers" },
          { "<Leader>R", function() Snacks.rename.rename_file() end, desc = "Rename file" },
          { "<Leader>t",  function() Snacks.terminal() end, desc = "Toggle terminal" },
          { "]w",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next word", mode = { "n", "t" } },
          { "[w",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev word", mode = { "n", "t" } },
        })
      end,
    },
  },
})

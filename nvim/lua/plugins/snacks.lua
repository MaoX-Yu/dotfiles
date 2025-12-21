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
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
        sections = {
          { section = "header" },
          { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          { section = "startup" },
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
    },
    -- stylua: ignore
    keys = {
      -- Git
      { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git browse", mode = { "n", "v" } },
      { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
      -- Other
      { "<leader>z",  function() Snacks.zen.zen() end, desc = "Toggle zen mode" },
      { "<leader>Z",  function() Snacks.zen.zoom() end, desc = "Toggle zoom" },
      { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle scratch buffer" },
      { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select scratch buffer" },
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete buffer" },
      { "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete other buffers" },
      { "<leader>cr", function() Snacks.rename.rename_file() end, desc = "Rename file" },
      { "<leader>t",  function() Snacks.terminal() end, desc = "Toggle terminal" },
      { "]w",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next word", mode = { "n", "t" } },
      { "[w",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev word", mode = { "n", "t" } },
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
              vim.g.autoformat = state
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

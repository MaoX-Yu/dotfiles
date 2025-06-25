return {
  {
    "nvim-lualine/lualine.nvim",
    cond = not vim.g.vscode,
    opts = function()
      local function location()
        local line = vim.fn.line(".")
        local col = vim.fn.charcol(".")
        return string.format("%d:%d", line, col)
      end
      local function fileinfo()
        local symbols = {
          unix = "LF",
          dos = "CRLF",
          mac = "CR",
        }
        local filetype = vim.o.filetype ~= "" and vim.o.filetype .. " " or ""
        local fileformat = symbols[vim.o.fileformat]
        return string.format("%s%s", filetype, fileformat)
      end

      return {
        options = {
          theme = "catppuccin",
          component_separators = { left = "|", right = "|" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = {
            {
              "filename",
              newfile_status = true,
              path = 1,
              symbols = {
                unnamed = "[Scratch]",
              },
            },
          },
          lualine_x = {
            {
              "lsp_status",
              icon = "",
              symbols = {
                spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
                done = "",
                separator = " ",
              },
            },
            {
              function()
                ---@diagnostic disable-next-line: undefined-field
                return require("noice").api.status.command.get()
              end,
              cond = function()
                ---@diagnostic disable-next-line: undefined-field
                return package.loaded["noice"] and require("noice").api.status.command.has()
              end,
              color = function()
                return { fg = Snacks.util.color("Statement") }
              end,
            },
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = function()
                return { fg = Snacks.util.color("Special") }
              end,
            },
            {
              function()
                return "  " .. require("dap").status()
              end,
              cond = function()
                return package.loaded["dap"] and require("dap").status() ~= ""
              end,
              color = function()
                return { fg = Snacks.util.color("Debug") }
              end,
            },
            "overseer",
            {
              "encoding",
              cond = function()
                local encoding = vim.o.fileencoding
                return encoding ~= "" and encoding ~= "utf-8"
              end,
            },
          },
          lualine_y = { fileinfo },
          lualine_z = { "progress", location },
        },
        extensions = {
          "avante",
          "lazy",
          "mason",
          "oil",
          "overseer",
          "quickfix",
        },
      }
    end,
  },
}

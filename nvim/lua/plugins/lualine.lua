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
      local showcmd_msg = ""
      vim.ui_attach(vim.api.nvim_create_namespace("showcmd_msg"), { ext_messages = true }, function(event, ...)
        if event == "msg_showcmd" then
          local content = ...
          showcmd_msg = #content > 0 and content[1][2] or showcmd_msg
        end
      end)

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
              ignore_lsp = { "mini.snippets" },
            },
            {
              function()
                return showcmd_msg
              end,
              cond = function()
                return showcmd_msg ~= nil
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
          lualine_y = {
            "bo:filetype",
            {
              "fileformat",
              symbols = {
                unix = "LF",
                dos = "CRLF",
                mac = "CR",
              },
            },
          },
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

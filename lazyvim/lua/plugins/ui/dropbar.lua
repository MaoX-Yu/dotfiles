return {
  {
    "Bekaboo/dropbar.nvim",
    enabled = true,
    cond = not vim.g.vscode,
    keys = function()
      local api = require("dropbar.api")
      return {
        { "<leader>;", api.pick, desc = "Pick Dropbar" },
      }
    end,
    opts = function()
      local utils = require("dropbar.utils")

      local enter = function()
        local menu = utils.menu.get_current()
        if not menu then
          return
        end
        local cursor = vim.api.nvim_win_get_cursor(menu.win)
        local entry = menu.entries[cursor[1]]
        local component = entry:first_clickable(entry.padding.left + entry.components[1]:bytewidth())
        if component then
          menu:click_on(component, nil, 1, "l")
        end
      end

      local close = function()
        local menu = utils.menu.get_current()
        while menu and menu.prev_menu do
          menu = menu.prev_menu
        end
        if menu then
          menu:close()
        end
      end

      return {
        icons = {
          ui = {
            bar = { separator = " " },
            menu = { separator = "" },
          },
        },
        bar = {
          pick = {
            pivots = "asdfghjklqwertyuiopzxcvbnm",
          },
        },
        menu = {
          -- When on, automatically set the cursor to the closest previous/next
          -- clickable component in the direction of cursor movement on CursorMoved
          quick_navigation = true,
          ---@type table<string, string|function|table<string, string|function>>
          keymaps = {
            ["l"] = function()
              local menu = utils.menu.get_current()
              if not menu then
                return
              end
              local row = vim.api.nvim_win_get_cursor(menu.win)[1]
              local component = menu.entries[row]:first_clickable()
              if component then
                menu:click_on(component, nil, 1, "l")
              end
            end,
            ["h"] = "<C-w>q",
            ["o"] = enter,
            ["<CR>"] = enter,
            ["q"] = close,
            ["<Esc>"] = close,
          },
        },
        sources = {
          treesitter = {
            valid_types = {
              "array",
              "boolean",
              "break_statement",
              "call",
              "case_statement",
              "class",
              "constant",
              "constructor",
              "continue_statement",
              "delete",
              "do_statement",
              "element",
              "enum",
              "enum_member",
              "event",
              "for_statement",
              "function",
              "h1_marker",
              "h2_marker",
              "h3_marker",
              "h4_marker",
              "h5_marker",
              "h6_marker",
              "if_statement",
              "interface",
              "keyword",
              "macro",
              "method",
              -- "module",
              "namespace",
              "null",
              "number",
              "operator",
              "package",
              "pair",
              "property",
              "reference",
              "repeat",
              "rule_set",
              "scope",
              "specifier",
              "struct",
              "switch_statement",
              "type",
              "type_parameter",
              "unit",
              "value",
              "variable",
              "while_statement",
              "declaration",
              "field",
              "identifier",
              "object",
              "statement",
            },
          },
        },
      }
    end,
  },
}

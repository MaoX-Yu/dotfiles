return {
  {
    "Bekaboo/dropbar.nvim",
    event = "LazyFile",
    opts = function()
      local api = require("dropbar.api")
      local utils = require("dropbar.utils")
      vim.keymap.set("n", "<Leader>;", api.pick, { desc = "Pick Dropbar" })
      vim.keymap.set("n", "[j", api.goto_context_start, { desc = "Goto context start" })
      vim.keymap.set("n", "]j", api.select_next_context, { desc = "Select next context" })

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
            bar = { separator = "  " },
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
      }
    end,
  },
}

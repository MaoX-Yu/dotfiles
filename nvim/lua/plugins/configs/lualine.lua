local M = {}

function M.opts()
  local colors = require("catppuccin.palettes").get_palette("macchiato")
  local icons = require("lazyvim.config").icons
  local mode_color = {
    n = colors.blue,
    i = colors.green,
    v = colors.flamingo,
    [""] = colors.flamingoj,
    V = colors.flamingo,
    c = colors.peach,
    no = colors.blue,
    s = colors.yellow,
    S = colors.yellow,
    [""] = colors.yellow,
    ic = colors.green,
    R = colors.red,
    Rv = colors.red,
    cv = colors.peach,
    ce = colors.peach,
    r = colors.teal,
    rm = colors.teal,
    ["r?"] = colors.teal,
    ["!"] = colors.peach,
    t = colors.green,
  }
  local conditions = {
    hide_in_width = function()
      return vim.fn.winwidth(0) > 80
    end,
  }

  local opts = {
    options = {
      theme = "auto",
      globalstatus = true,
      disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
      component_separators = "",
      section_separators = "",
    },
    sections = {
      -- these are to remove the defaults
      lualine_a = {},
      lualine_b = {},
      lualine_y = {},
      lualine_z = {},
      -- These will be filled later
      lualine_c = {},
      lualine_x = {},
    },
    inactive_sections = {
      -- these are to remove the defaults
      lualine_a = {},
      lualine_b = {},
      lualine_y = {},
      lualine_z = {},
      lualine_c = {},
      lualine_x = {},
    },
    extensions = { "neo-tree", "lazy" },
  }

  -- Inserts a component in lualine_c at left section
  local function ins_left(component)
    table.insert(opts.sections.lualine_c, component)
  end

  -- Inserts a component in lualine_x at right section
  local function ins_right(component)
    table.insert(opts.sections.lualine_x, component)
  end

  ins_left({
    function()
      return "▊"
    end,
    color = function()
      return { fg = mode_color[vim.fn.mode()] }
    end,
    padding = { left = 0, right = 1 },
  })

  ins_left({
    "mode",
    color = function()
      return { fg = mode_color[vim.fn.mode()], gui = "bold" }
    end,
    padding = { right = 1 },
  })

  ins_left({
    "branch",
    color = { fg = colors.mauve, gui = "bold" },
  })

  ins_left(LazyVim.lualine.root_dir())

  ins_left({
    "diff",
    symbols = {
      added = icons.git.added,
      modified = icons.git.modified,
      removed = icons.git.removed,
    },
    source = function()
      local gitsigns = vim.b.gitsigns_status_dict
      if gitsigns then
        return {
          added = gitsigns.added,
          modified = gitsigns.changed,
          removed = gitsigns.removed,
        }
      end
    end,
  })

  ins_left(LazyVim.lualine.pretty_path())

  ins_left({
    function()
      return "%="
    end,
  })

  ins_left({
    function()
      local msg = ""
      local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
      local clients = vim.lsp.get_clients()
      for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
          if msg ~= "" then
            msg = msg .. ", "
          end
          msg = msg .. client.name
        end
      end
      if msg == "" then
        return "No Active Lsp"
      end
      return msg
    end,
    cond = function()
      local clients = vim.lsp.get_clients()
      if next(clients) == nil then
        return false
      end
      return true
    end,
    icon = " ",
    color = { fg = colors.text, gui = "bold" },
  })

  ins_right({
    function()
      return require("noice").api.status.command.get()
    end,
    cond = function()
      return package.loaded["noice"] and require("noice").api.status.command.has()
    end,
    color = LazyVim.ui.fg("Statement"),
  })

  ins_right({
    function()
      return require("noice").api.status.mode.get()
    end,
    cond = function()
      return package.loaded["noice"] and require("noice").api.status.mode.has()
    end,
    color = LazyVim.ui.fg("Constant"),
  })

  ins_right({
    function()
      return "  " .. require("dap").status()
    end,
    cond = function()
      return package.loaded["dap"] and require("dap").status() ~= ""
    end,
    color = LazyVim.ui.fg("Debug"),
  })

  ins_right({
    require("lazy.status").updates,
    cond = require("lazy.status").has_updates,
    color = LazyVim.ui.fg("Special"),
  })

  ins_right({
    "diagnostics",
    symbols = {
      error = icons.diagnostics.Error,
      warn = icons.diagnostics.Warn,
      info = icons.diagnostics.Info,
      hint = icons.diagnostics.Hint,
    },
  })

  ins_right({ "location", separator = " ", padding = { left = 1, right = 0 } })

  ins_right({ "progress", padding = { left = 0, right = 1 } })

  ins_right({
    "o:encoding",
    fmt = string.upper,
    cond = conditions.hide_in_width,
    color = { fg = colors.green },
  })

  ins_right({
    "fileformat",
    fmt = string.upper,
    icons_enabled = false,
    cond = conditions.hide_in_width,
    color = { fg = colors.green },
  })

  ins_right({
    "filetype",
    separator = "",
    padding = { left = 1, right = 0 },
  })

  ins_right({
    function()
      return "▊"
    end,
    color = function()
      return { fg = mode_color[vim.fn.mode()] }
    end,
    padding = { left = 1 },
  })

  return opts
end

return M

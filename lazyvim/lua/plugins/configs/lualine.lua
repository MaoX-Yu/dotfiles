local M = {}

function M.opts(opts)
  local colors = require("catppuccin.palettes").get_palette("macchiato")
  local icons = LazyVim.config.icons
  local conditions = {
    hide_in_width = function()
      return vim.fn.winwidth(0) > 80
    end,
  }

  opts.options = opts.options or {}
  opts.options.component_separators = ""
  opts.options.section_separators = ""

  opts.sections = opts.sections or {}
  opts.sections.lualine_c = {
    LazyVim.lualine.root_dir(),
    {
      "diagnostics",
      symbols = {
        error = icons.diagnostics.Error,
        warn = icons.diagnostics.Warn,
        info = icons.diagnostics.Info,
        hint = icons.diagnostics.Hint,
      },
    },
    { LazyVim.lualine.pretty_path() },
  }
  table.insert(opts.sections.lualine_x, { "overseer" })
  table.insert(opts.sections.lualine_x, {
    "o:encoding",
    fmt = string.upper,
    cond = conditions.hide_in_width,
    color = { fg = colors.green },
  })
  table.insert(opts.sections.lualine_x, {
    "fileformat",
    cond = conditions.hide_in_width,
    color = { fg = colors.green },
  })
  opts.sections.lualine_x = vim.list_extend(opts.sections.lualine_x, opts.sections.lualine_y or {})
  table.insert(opts.sections.lualine_x, {
    "filetype",
    colored = true,
    separator = "",
    padding = { left = 1, right = 1 },
  })
  opts.sections.lualine_y = {}
  opts.sections.lualine_z = {}

  return opts
end

return M

local M = {}

function M.opts(opts)
  local icons = LazyVim.config.icons

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
    {
      "filename",
      newfile_status = true,
      path = 1,
      symbols = {
        readonly = "[RO]",
      },
    },
  }
  table.insert(opts.sections.lualine_x, { "overseer" })
  table.insert(opts.sections.lualine_x, {
    "o:encoding",
    fmt = string.upper,
    cond = function()
      return vim.opt.fileencoding:get() ~= "utf-8"
    end,
  })
  table.insert(opts.sections.lualine_x, {
    "fileformat",
    fmt = string.upper,
    icons_enabled = false,
  })
  table.insert(opts.sections.lualine_x, {
    "progress",
    separator = " ",
    fmt = string.upper,
    padding = { left = 1, right = 0 },
  })
  table.insert(opts.sections.lualine_x, {
    "location",
    padding = { left = 0, right = 1 },
  })
  table.insert(opts.sections.lualine_x, {
    "filetype",
    colored = true,
    separator = "",
    padding = { left = 1, right = 1 },
  })
  opts.sections.lualine_y = {}
  opts.sections.lualine_z = {}

  opts.extensions = {
    "fzf",
    "lazy",
    "man",
    "mason",
    "neo-tree",
    "nvim-dap-ui",
    "oil",
    "overseer",
    "quickfix",
    "trouble",
  }

  return opts
end

return M

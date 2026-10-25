local S = require("utils.snacks")

local M = {}

local function register()
  local toggle = S.toggle

  toggle.option("spell", { name = "Spelling" }):map("<Leader>us")
  toggle.option("wrap", { name = "Wrap" }):map("<Leader>uw")
  toggle.option("relativenumber", { name = "Relative Number" }):map("<Leader>uL")
  toggle.diagnostics():map("<Leader>ud")
  toggle.line_number():map("<Leader>ul")
  toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<Leader>uc")
  toggle.treesitter():map("<Leader>uT")
  toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<Leader>ub")
  toggle.inlay_hints():map("<Leader>uh")
  toggle.indent():map("<Leader>ug")
  toggle.dim():map("<Leader>uD")

  toggle({
    name = "Auto Format (Global)",
    get = function()
      return vim.g.autoformat
    end,
    set = function(state)
      vim.g.autoformat = state
    end,
  }):map("<Leader>uf")

  toggle({
    name = "Auto Format (Buffer)",
    get = function()
      return vim.b.autoformat == nil and true or vim.b.autoformat
    end,
    set = function(state)
      vim.b.autoformat = state
    end,
  }):map("<Leader>uF")

  toggle({
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
end

function M.setup()
  register()
end

return M

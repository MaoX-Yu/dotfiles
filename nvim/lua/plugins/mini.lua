return {
  {
    "echasnovski/mini.nvim",
    lazy = false,
    version = false,
    config = function()
      local gen_spec = require("mini.ai").gen_spec
      local hipatterns = require("mini.hipatterns")

      require("mini.ai").setup({
        custom_textobjects = {
          o = gen_spec.treesitter({ -- code block
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          f = gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
          c = gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
          d = { "%f[%d]%d+" }, -- digits
          e = { -- Word with case
            { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
            "^().*()$",
          },
          g = function()
            local from = { line = 1, col = 1 }
            local to = {
              line = vim.fn.line("$"),
              col = math.max(vim.fn.getline("$"):len(), 1),
            }
            return { from = from, to = to }
          end,
          u = gen_spec.function_call(), -- u for "Usage"
          U = gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
        },
      })
      require("mini.hipatterns").setup({
        highlighters = {
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })
      require("mini.icons").setup({})
      require("mini.move").setup({})
      require("mini.pairs").setup({})
      require("mini.splitjoin").setup({})
      require("mini.surround").setup({
        mappings = {
          add = "gsa", -- Add surrounding in Normal and Visual modes
          delete = "gsd", -- Delete surrounding
          find = "gsf", -- Find surrounding (to the right)
          find_left = "gsF", -- Find surrounding (to the left)
          highlight = "gsh", -- Highlight surrounding
          replace = "gsr", -- Replace surrounding
          update_n_lines = "gsn", -- Update `n_lines`
        },
      })
      require("mini.tabline").setup({ tabpage_section = "right" })

      MiniIcons.mock_nvim_web_devicons()
    end,
  },
}

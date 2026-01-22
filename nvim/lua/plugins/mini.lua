return {
  {
    "nvim-mini/mini.nvim",
    lazy = false,
    version = false,
    config = function()
      local gen_spec = require("mini.ai").gen_spec
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

      require("mini.cmdline").setup({
        autocomplete = {
          enable = false,
        },
      })

      require("mini.files").setup({
        mappings = {
          go_in = "",
          go_in_plus = "<CR>",
          go_out = "-",
          go_out_plus = "",
        },
        windows = {
          preview = true,
          width_preview = 50,
        },
      })

      local hipatterns = require("mini.hipatterns")
      require("mini.hipatterns").setup({
        highlighters = {
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })

      require("mini.icons").setup({})
      MiniIcons.mock_nvim_web_devicons()

      require("mini.move").setup({})

      require("mini.splitjoin").setup({})

      require("mini.surround").setup({
        mappings = {
          add = "ys", -- Add surrounding in Normal and Visual modes
          delete = "ds", -- Delete surrounding
          find = "", -- Find surrounding (to the right)
          find_left = "", -- Find surrounding (to the left)
          highlight = "", -- Highlight surrounding
          replace = "cs", -- Replace surrounding
        },
      })
    end,
    keys = {
      {
        "<leader>e",
        function()
          MiniFiles.open(vim.api.nvim_buf_get_name(0))
        end,
        desc = "File explorer",
      },
      {
        "<leader>E",
        function()
          MiniFiles.open()
        end,
        desc = "File explorer (cwd)",
      },
    },
  },
}

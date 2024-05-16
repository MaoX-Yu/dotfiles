return {
  {
    "chrisgrieser/nvim-spider",
    lazy = true,
    opts = {
      skipInsignificantPunctuation = false,
    },
    -- stylua: ignore
    keys = {
      { "w",  "<cmd>lua require('spider').motion('w')<CR>",  desc = "Spider-w",  mode = { "n", "o", "x" } },
      { "e",  "<cmd>lua require('spider').motion('e')<CR>",  desc = "Spider-e",  mode = { "n", "o", "x" } },
      { "b",  "<cmd>lua require('spider').motion('b')<CR>",  desc = "Spider-b",  mode = { "n", "o", "x" } },
      { "ge", "<cmd>lua require('spider').motion('ge')<CR>", desc = "Spider-ge", mode = { "n", "o", "x" } },
    },
  },
  {
    "folke/persistence.nvim",
    -- stylua: ignore
    keys = {
      { "<leader>qs", false },
      { "<leader>ql", false },
      { "<leader>qd", false },
      { "<leader>Ss", function() require("persistence").load() end,                desc = "Restore Session"            },
      { "<leader>Sl", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session"       },
      { "<leader>Sd", function() require("persistence").stop() end,                desc = "Don't Save Current Session" },
    },
  },
  {
    "max397574/better-escape.nvim",
    event = "LazyFile",
    opts = {
      mapping = { "jj", "fd" },
    },
  },
  {
    "nmac427/guess-indent.nvim",
    event = "LazyFile",
    config = true,
  },
  {
    "echasnovski/mini.splitjoin",
    event = "LazyFile",
    opts = {},
  },
  {
    "danymat/neogen",
    cmd = "Neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = {
      snippet_engine = "luasnip",
      languages = {
        lua = { template = { annotation_convention = "ldoc" } },
        python = { template = { annotation_convention = "google_docstrings" } },
        typescript = { template = { annotation_convention = "tsdoc" } },
        typescriptreact = { template = { annotation_convention = "tsdoc" } },
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>a<cr>", function() require("neogen").generate { type = "current" } end, desc = "Current"  },
      { "<leader>ac",    function() require("neogen").generate { type = "class" } end,   desc = "Class"    },
      { "<leader>af",    function() require("neogen").generate { type = "func" } end,    desc = "Function" },
      { "<leader>at",    function() require("neogen").generate { type = "type" } end,    desc = "Type"     },
      { "<leader>aF",    function() require("neogen").generate { type = "file" } end,    desc = "File"     },
    },
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "LazyFile",
    main = "rainbow-delimiters.setup",
  },
  {
    "folke/trouble.nvim",
    branch = "dev",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
      {
        "<leader>cS",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP references/definitions/... (Trouble)",
      },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").prev({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous Trouble/Quickfix Item",
      },
    },
  },
  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      for _, pos in ipairs({ "top", "bottom", "left", "right" }) do
        opts[pos] = opts[pos] or {}
        table.insert(opts[pos], {
          ft = "trouble",
          filter = function(_, win)
            return vim.w[win].trouble
              and vim.w[win].trouble.position == pos
              and vim.w[win].trouble.type == "split"
              and vim.w[win].trouble.relative == "editor"
              and not vim.w[win].trouble_preview
          end,
        })
      end
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "debugloop/telescope-undo.nvim" },
    -- stylua: ignore
    keys = {
      { "<leader>su", "<cmd>Telescope undo<CR>", desc = "Undos" },
    },
    opts = function(_, opts)
      require("telescope").load_extension("undo")
      opts.defaults.layout_config = {
        horizontal = {
          preview_width = 0.55,
        },
      }
      -- trouble
      local open_with_trouble = require("trouble.sources.telescope").open
      opts = vim.tbl_deep_extend("force", opts, {
        defaults = {
          mappings = {
            i = {
              ["<c-t>"] = open_with_trouble,
              ["<a-t>"] = open_with_trouble,
            },
          },
        },
      })
      return opts
    end,
  },
}

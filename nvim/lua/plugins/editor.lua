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
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = function(_, opts)
      opts.defaults.layout_config = {
        horizontal = {
          preview_width = 0.55,
        },
      }
      return opts
    end,
  },
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
      { "<leader>su", "<cmd>UndotreeToggle<cr>", desc = "Undo Tree" },
    },
    init = function()
      vim.g.undotree_WindowLayout = 4
    end,
  },
  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      opts.right = opts.right or {}
      opts.bottom = opts.bottom or {}
      table.insert(opts.right, {
        title = "Undo Tree",
        ft = "undotree",
        open = "UndotreeToggle",
      })
      table.insert(opts.bottom, {
        title = "Diff",
        ft = "diff",
        open = "UndotreeToggle",
      })
    end,
  },
}

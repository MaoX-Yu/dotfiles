return {
  {
    "chrisgrieser/nvim-spider",
    lazy = true,
    opts = {
      skipInsignificantPunctuation = false,
    },
    keys = {
      { "w", "<cmd>lua require('spider').motion('w')<CR>", desc = "Spider-w", mode = { "n", "o", "x" } },
      { "e", "<cmd>lua require('spider').motion('e')<CR>", desc = "Spider-e", mode = { "n", "o", "x" } },
      { "b", "<cmd>lua require('spider').motion('b')<CR>", desc = "Spider-b", mode = { "n", "o", "x" } },
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
      { "<leader>Ss", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>Sl", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>Sd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
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
      { "<leader>a<cr>", function() require("neogen").generate { type = "current" } end, desc = "Current" },
      { "<leader>ac", function() require("neogen").generate { type = "class" } end, desc = "Class" },
      { "<leader>af", function() require("neogen").generate { type = "func" } end, desc = "Function" },
      { "<leader>at", function() require("neogen").generate { type = "type" } end, desc = "Type" },
      { "<leader>aF", function() require("neogen").generate { type = "file" } end, desc = "File" },
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
    dependencies = { "debugloop/telescope-undo.nvim" },
    keys = {
      {
        "<leader>su",
        "<cmd>Telescope undo<CR>",
        desc = "Undos",
      },
    },
    opts = function(_, opts)
      require("telescope").load_extension("undo")
      opts.defaults.layout_config = {
        horizontal = {
          preview_width = 0.55,
        },
      }
      return opts
    end,
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    cmd = { "Refactor" },
    opts = {},
    keys = function()
      require("telescope").load_extension("refactoring")
      return {
        {
          "<leader>re",
          [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
          { silent = true, expr = false },
          mode = { "v", "x" },
          desc = "Extract Function",
        },
        {
          "<leader>rf",
          [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
          { silent = true, expr = false },
          mode = { "v", "x" },
          desc = "Extract Function To File",
        },
        {
          "<leader>rv",
          [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
          { silent = true, expr = false },
          mode = { "v", "x" },
          desc = "Extract Variable",
        },
        {
          "<leader>ri",
          [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
          { silent = true, expr = false },
          mode = { "n", "v", "x" },
          desc = "Inline Variable",
        },
        {
          "<leader>rb",
          function()
            require("refactoring").refactor("Extract Block")
          end,
          { silent = true, expr = false },
          mode = { "n" },
          desc = "Extract Block",
        },
        {
          "<leader>rbf",
          function()
            require("refactoring").refactor("Extract Block To File")
          end,
          { silent = true, expr = false },
          mode = { "n" },
          desc = "Extract Block To File",
        },
        {
          "<leader>rr",
          function()
            require("telescope").extensions.refactoring.refactors()
          end,
          { silent = true, expr = false },
          desc = "Select Refactor",
        },
        {
          "<leader>rp",
          function()
            require("refactoring").debug.printf({ below = false })
          end,
          mode = { "n" },
          desc = "Debug: Print Function",
        },
        {
          "<leader>rd",
          function()
            require("refactoring").debug.print_var({ normal = true, below = false })
          end,
          mode = { "n" },
          desc = "Debug: Print Variable",
        },
        {
          "<leader>rd",
          function()
            require("refactoring").debug.print_var({ below = false })
          end,
          mode = { "v" },
          desc = "Debug: Print Variable",
        },
        {
          "<leader>rc",
          function()
            require("refactoring").debug.cleanup({})
          end,
          mode = { "n" },
          desc = "Debug: Clean Up",
        },
      }
    end,
  },
}

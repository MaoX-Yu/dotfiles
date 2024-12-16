return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    lazy = vim.fn.argc(-1) == 0,
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    opts_extend = { "ensure_installed" },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "query",
        "regex",
        "toml",
        "vim",
        "vimdoc",
        "yaml",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<M-o>",
          node_incremental = "<M-o>",
          scope_incremental = false,
          node_decremental = "<M-i>",
        },
      },
      textobjects = {
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]f"] = { query = "@function.outer", desc = "Next function start" },
            ["]]"] = { query = "@class.outer", desc = "Next class start" },
            ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
          },
          goto_next_end = {
            ["]F"] = { query = "@function.outer", desc = "Next function end" },
            ["]["] = { query = "@class.outer", desc = "Next class end" },
          },
          goto_previous_start = {
            ["[f"] = { query = "@function.outer", desc = "Previous function start" },
            ["[["] = { query = "@class.outer", desc = "Previous class start" },
            ["[z"] = { query = "@fold", query_group = "folds", desc = "Previous fold" },
          },
          goto_previous_end = {
            ["[F"] = { query = "@function.outer", desc = "Previous function end" },
            ["[]"] = { query = "@class.outer", desc = "Previous class end" },
          },
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    opts = function()
      local tsc = require("treesitter-context")
      Snacks.toggle({
        name = "Treesitter Context",
        get = tsc.enabled,
        set = function(state)
          if state then
            tsc.enable()
          else
            tsc.disable()
          end
        end,
      }):map("<leader>ut")
      return { mode = "cursor", max_lines = 3 }
    end,
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<BS>", "<M-i>", desc = "Decrement Selection", mode = "x", remap = true },
        { "<c-space>", "<M-o>", desc = "Increment Selection", mode = { "x", "n" }, remap = true },
        { "<M-i>", desc = "Decrement Selection", mode = "x" },
        { "<M-o>", desc = "Increment Selection", mode = { "x", "n" } },
      },
    },
  },
}

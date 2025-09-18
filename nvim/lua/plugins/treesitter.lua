return {
  {
    "nvim-treesitter/nvim-treesitter",
    cond = not vim.g.vscode,
    version = false,
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    opts_extend = { "ensure_installed" },
    opts = {
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
    },
    config = function(_, opts)
      require("nvim-treesitter").install(opts.ensure_installed)

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("mao.treesitter", { clear = true }),
        callback = function()
          local ok = pcall(vim.treesitter.start)
          if ok then
            vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
          end
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    opts = {
      move = {
        set_jumps = true,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter-textobjects").setup(opts)

      local move = require("nvim-treesitter-textobjects.move")
      local map = vim.keymap.set

      map({ "n", "x", "o" }, "]f", function()
        move.goto_next_start("@function.outer", "textobjects")
      end, { desc = "Next function start" })
      map({ "n", "x", "o" }, "]]", function()
        move.goto_next_start("@class.outer", "textobjects")
      end, { desc = "Next class start" })
      map({ "n", "x", "o" }, "]z", function()
        move.goto_next_start("@fold", "folds")
      end, { desc = "Next fold" })

      map({ "n", "x", "o" }, "]F", function()
        move.goto_next_end("@function.outer", "textobjects")
      end, { desc = "Next function end" })
      map({ "n", "x", "o" }, "][", function()
        move.goto_next_end("@class.outer", "textobjects")
      end, { desc = "Next clss end" })

      map({ "n", "x", "o" }, "[f", function()
        move.goto_previous_start("@function.outer", "textobjects")
      end, { desc = "Previous function start" })
      map({ "n", "x", "o" }, "[[", function()
        move.goto_previous_start("@class.outer", "textobjects")
      end, { desc = "Previous class start" })
      map({ "n", "x", "o" }, "[z", function()
        move.goto_previous_start("@fold", "folds")
      end, { desc = "Previous fold" })

      map({ "n", "x", "o" }, "[F", function()
        move.goto_previous_end("@function.outer", "textobjects")
      end, { desc = "Previous function end" })
      map({ "n", "x", "o" }, "[]", function()
        move.goto_previous_end("@class.outer", "textobjects")
      end, { desc = "Previous class end" })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    cond = not vim.g.vscode,
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
}

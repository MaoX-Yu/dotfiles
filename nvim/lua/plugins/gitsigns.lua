return {
  {
    "lewis6991/gitsigns.nvim",
    cond = not vim.g.vscode,
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        changedelete = { text = "▎" },
      },
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end

        -- Navigation
        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end, "Next Hunk")
        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end, "Prev Hunk")
        map("n", "]H", function()
          gitsigns.nav_hunk("last")
        end, "Last Hunk")
        map("n", "[H", function()
          gitsigns.nav_hunk("first")
        end, "First Hunk")

        -- Actions
        map("n", "<leader>gh", gitsigns.stage_hunk, "Stage Hunk")
        map("n", "<leader>gH", gitsigns.stage_buffer, "Stage Buffer")
        map("v", "<leader>gh", function()
          gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Stage Line")
        map("n", "<leader>gr", gitsigns.reset_hunk, "Reset Hunk")
        map("n", "<leader>gR", gitsigns.reset_buffer, "Reset Buffer")
        map("v", "<leader>gr", function()
          gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Reset Line")

        map("n", "<leader>gp", gitsigns.preview_hunk, "Preview Hunk")
        map("n", "<leader>gi", gitsigns.preview_hunk_inline, "Preview Hunk Inline")

        map("n", "<leader>gq", gitsigns.setqflist, "Set Quickfix (Buffer)")
        map("n", "<leader>gQ", function()
          gitsigns.setqflist("all")
        end, "Set Quickfix")

        -- Text object
        map({ "o", "x" }, "ih", gitsigns.select_hunk, "GitSigns Select Hunk")
      end,
    },
  },
}

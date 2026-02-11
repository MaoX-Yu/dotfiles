P:add({
  {
    src = "https://github.com/lewis6991/gitsigns.nvim",
    data = {
      config = function()
        require("gitsigns").setup({
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
            end, "Next hunk")
            map("n", "[h", function()
              if vim.wo.diff then
                vim.cmd.normal({ "[c", bang = true })
              else
                gitsigns.nav_hunk("prev")
              end
            end, "Prev hunk")
            map("n", "]H", function()
              gitsigns.nav_hunk("last")
            end, "Last hunk")
            map("n", "[H", function()
              gitsigns.nav_hunk("first")
            end, "First hunk")

            -- Actions
            map("n", "<Leader>gh", gitsigns.stage_hunk, "Stage hunk")
            map("n", "<Leader>gH", gitsigns.stage_buffer, "Stage buffer")
            map("v", "<Leader>gh", function()
              gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, "Stage line")
            map("n", "<Leader>gr", gitsigns.reset_hunk, "Reset hunk")
            map("n", "<Leader>gR", gitsigns.reset_buffer, "Reset buffer")
            map("v", "<Leader>gr", function()
              gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, "Reset line")

            map("n", "<Leader>gp", gitsigns.preview_hunk, "Preview hunk")
            map("n", "<Leader>gi", gitsigns.preview_hunk_inline, "Preview hunk inline")

            map("n", "<Leader>gb", function()
              gitsigns.blame_line({ full = true })
            end, "Blame line")

            map("n", "<Leader>gd", gitsigns.diffthis, "Diff")
            map("n", "<Leader>gD", function()
              gitsigns.diffthis("~")
            end, "Diff HEAD")

            map("n", "<Leader>gq", gitsigns.setqflist, "Set quickfix (Buffer)")
            map("n", "<Leader>gQ", function()
              gitsigns.setqflist("all")
            end, "Set quickfix")

            -- Toggles
            map("n", "<Leader>gl", gitsigns.toggle_current_line_blame, "Toggle blame line")
            map("n", "<Leader>gw", gitsigns.toggle_word_diff, "Toggle word diff")

            -- Text object
            map({ "o", "x" }, "ih", gitsigns.select_hunk, "GitSigns select hunk")
          end,
        })
      end,
    },
  },
})

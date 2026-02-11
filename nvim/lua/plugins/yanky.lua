P:add({
  {
    src = "https://github.com/gbprod/yanky.nvim",
    data = {
      event = { "BufReadPost", "BufNewFile" },
      config = function()
        require("yanky").setup({
          textobj = {
            enabled = true,
          },
        })

        P.map({
          { "<Leader>p", "<Cmd>YankyRingHistory<CR>", mode = { "n", "x" }, desc = "Open yank history" },
          { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank text" },
          { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put text after cursor" },
          { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put text before cursor" },
          { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put text after selection" },
          { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put text before selection" },
          { "[y", "<Plug>(YankyCycleForward)", desc = "Cycle forward through yank history" },
          { "]y", "<Plug>(YankyCycleBackward)", desc = "Cycle backward through yank history" },
          { "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (Linewise)" },
          { "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (Linewise)" },
          { ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and indent right" },
          { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and indent left" },
          { ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right" },
          { "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put before and indent left" },
          { "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put after and indent" },
          { "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put before and indent" },
          {
            "iy",
            function()
              require("yanky.textobj").last_put()
            end,
            mode = { "o", "x" },
            desc = "Last put",
          },
        })
      end,
    },
  },
})

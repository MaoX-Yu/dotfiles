return {
  {
    "kevinhwang91/nvim-ufo",
    event = "LazyFile",
    init = function()
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
      -- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep:│,foldclose:]]
      vim.o.foldcolumn = "1" -- '0' is not bad
      vim.o.foldenable = true
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
    end,
    opts = {
      preview = {
        mappings = {
          scrollB = "<C-b>",
          scrollF = "<C-f>",
          scrollU = "<C-u>",
          scrollD = "<C-d>",
        },
      },
      provider_selector = function(_, filetype, buftype)
        return (filetype == "" or buftype == "nofile") and "indent" -- only use indent until a file is opened
          or { "treesitter", "indent" } -- if file opened, try to use treesitter if available
      end,
    },
    -- stylua: ignore
    keys = {
      { "zR", function() require("ufo").openAllFolds() end,         desc = "Open All Folds"  },
      { "zM", function() require("ufo").closeAllFolds() end,        desc = "Close All Folds" },
      { "zr", function() require("ufo").openFoldsExceptKinds() end, desc = "Fold less"       },
      {
        "K",
        function()
          local winid = require("ufo").peekFoldedLinesUnderCursor()
          if not winid then
            vim.lsp.buf.hover()
          end
        end,
        desc = "Hover",
      },
    },
    dependencies = {
      "kevinhwang91/promise-async",
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          local builtin = require("statuscol.builtin")
          require("statuscol").setup({
            relculright = true,
            ft_ignore = { "help", "vim", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
            segments = {
              {
                text = { builtin.foldfunc, " " },
                condition = { true, builtin.not_empty },
                click = "v:lua.ScFa",
              },
              {
                text = { builtin.lnumfunc, " " },
                condition = { true, builtin.not_empty },
                click = "v:lua.ScLa",
              },
              {
                text = { "%s" },
                click = "v:lua.ScSa",
              },
            },
          })
        end,
      },
    },
  },
}

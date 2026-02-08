local utils = require("utils") ---@as MaoUtils
local lazy = utils.pack.lazy

vim.pack.add({
  {
    src = "https://github.com/folke/which-key.nvim",
    data = {
      config = function()
        ---@diagnostic disable: missing-fields
        require("which-key").setup({
          preset = "helix",
          triggers = {
            { "<Leader>", mode = { "n", "v" } },
            { "g", mode = { "n", "v" } },
            { "z", mode = { "n", "v" } },
            { "<C-w>", mode = { "n", "v" } },
            { "]", mode = { "n", "v" } },
            { "[", mode = { "n", "v" } },

            -- Marks
            { "'", mode = { "n", "v" } },
            { "`", mode = { "n", "v" } },

            -- Registers
            { '"', mode = { "n", "v" } },
            { "<C-r>", mode = { "i", "c" } },
          },
          win = {
            no_overlap = false,
          },
          expand = function(node)
            return not node.desc -- expand all nodes without a description
          end,
          icons = {
            separator = "│",
            group = "",
            mappings = false,
            keys = {
              BS = "󰁮 ",
            },
          },
          show_help = false,
          spec = {
            { "f", desc = "Find next char" },
            { "F", desc = "Find prev char" },
            { "t", desc = "Find next char tail" },
            { "T", desc = "Find prev char tail" },
            { ";", desc = "Next find result" },
            { ",", desc = "Prev find result" },
            { "]d", desc = "Next diagnostic" },
            { "[d", desc = "Previous diagnostic" },
            { "]D", desc = "Last diagnostic" },
            { "[D", desc = "First diagnostic" },
            { "<", group = "indent left" },
            { ">", group = "indent right" },
            { "=", group = "indent" },
            { "<Leader>", group = "leader" },
            { "<Leader>o", group = "overseer" },
            { "<BS>", "<M-i>", desc = "Decrement selection", mode = "x", remap = true },
            { "<C-Space>", "<M-o>", desc = "Increment selection", mode = { "x", "n" }, remap = true },
            { "<M-i>", desc = "Decrement selection", mode = "x" },
            { "<M-o>", desc = "Increment selection", mode = { "x", "n" } },
            {
              mode = { "n", "v" },
              { "[", group = "prev" },
              { "]", group = "next" },
              { "g", group = "goto" },
              { "z", group = "fold" },
              { "<Leader><Tab>", group = "tabs" },
              { "<Leader>A", group = "avante" },
              { "<Leader>c", group = "code" },
              { "<Leader>d", group = "debug" },
              { "<Leader>g", group = "git" },
              { "<Leader>s", group = "search" },
              { "<Leader>u", group = "ui" },
              { "<Leader>x", group = "quickfix" },
              {
                "<Leader>b",
                group = "buffer",
                expand = function()
                  return require("which-key.extras").expand.buf()
                end,
              },
              {
                "<Leader>w",
                group = "windows",
                proxy = "<c-w>",
                expand = function()
                  return require("which-key.extras").expand.win()
                end,
              },
              { "gx", desc = "Open with system app" },
              { "<C-_>", hidden = true },
            },
          },
        } --[[@as wk.Opts]])
      end,
    },
  },
}, {
  load = lazy,
})

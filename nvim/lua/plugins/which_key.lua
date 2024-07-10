return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      key_labels = {
        ["<space>"] = "SPC",
        ["<cr>"] = "CR",
        ["<CR>"] = "CR",
        ["<tab>"] = "TAB",
        ["<bs>"] = "BS",
        ["<esc>"] = "ESC",
        ["<leader>"] = "Leader",
      },
      icons = {
        group = "",
      },
      popup_mappings = {
        scroll_down = "<c-f>",
        scroll_up = "<c-b>",
      },
      window = {
        border = "single",
        position = "top",
      },
      defaults = {
        ["g"] = { name = "Goto" },
        ["gs"] = { name = "Surround" },
        ["z"] = { name = "Fold" },
        ["="] = { name = "Apply Filter" },
        ["]"] = { name = "Next" },
        ["["] = { name = "Prev" },
        ["<C-w>"] = { name = "Window" },
        ["<leader>"] = { name = "Leader" },
        ["<leader>b"] = { name = "󰓩 Buffer" },
        ["<leader>c"] = { name = " Code" },
        ["<leader>f"] = { name = "󰈞 Find/File" },
        ["<leader>g"] = { name = "󰊢 Git" },
        ["<leader>gh"] = { name = "Hunks", ["🚫"] = "which_key_ignore" },
        ["<leader>o"] = { name = " Overseer" },
        ["<leader>q"] = { "Quit All" },
        ["<leader>r"] = { name = "󰑕 Refactor" },
        ["<leader>s"] = { name = " Search" },
        ["<leader>S"] = { name = "󱂬 Session" },
        ["<leader>t"] = { name = " Test" },
        ["<leader><tab>"] = { name = "󰓩 Tabs" },
        ["<leader>u"] = { name = " UI" },
        ["<leader>w"] = { name = " Windows" },
        ["<leader>x"] = { name = "󱍼 Trouble" },
      },
    },
  },
}

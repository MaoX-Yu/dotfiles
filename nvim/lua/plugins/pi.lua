P:add({
  {
    src = "https://github.com/carderne/pi-nvim",
    cmd = {
      "Pi",
      "PiSend",
      "PiSendFile",
      "PiSendSelection",
      "PiSendBuffer",
      "PiPing",
      "PiSessions",
    },
    data = {
      config = function()
        require("pi-nvim").setup({
          set_default_keymaps = false,
        })
      end,
    },
  },
})

P.map({
  { "<Leader>aa", "<Cmd>Pi<CR>", mode = { "n", "v" }, desc = "Pi" },
  { "<Leader>ap", "<Cmd>PiSend<CR>", desc = "Pi send" },
  { "<Leader>af", "<Cmd>PiSendFile<CR>", desc = "Pi send file" },
  { "<Leader>as", "<Cmd>PiSendSelection<CR>", mode = { "v" }, desc = "Pi send selection" },
  { "<Leader>ab", "<Cmd>PiSendBuffer<CR>", desc = "Pi send buffer" },
})

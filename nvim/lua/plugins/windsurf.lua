return {
  {
    "Exafunction/windsurf.nvim",
    cond = not vim.g.vscode,
    event = "InsertEnter",
    cmd = "Codeium",
    opts = {
      virtual_text = {
        enabled = true,
        filetypes = {
          snacks_picker_input = false,
        },
        default_filetype_enabled = true,
      },
    },
    config = function(_, opts)
      require("codeium").setup(opts)
    end,
  },
}

return {
  {
    "Exafunction/windsurf.nvim",
    event = "InsertEnter",
    cmd = "Codeium",
    opts = {
      virtual_text = {
        enabled = true,
      },
    },
    config = function(_, opts)
      require("codeium").setup(opts)
    end
  },
}

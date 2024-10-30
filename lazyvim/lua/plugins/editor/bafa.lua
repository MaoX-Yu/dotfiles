return {
  {
    "MaoX-Yu/bafa.nvim",
    keys = {
      {
        "<leader>,",
        function()
          require("bafa.ui").toggle()
        end,
        desc = "Switch Buffer",
      },
    },
  },
}

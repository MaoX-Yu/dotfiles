local build_cmd = LazyVim.is_win() and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
  or "make"

return {
  {
    "yetone/avante.nvim",
    version = false,
    event = "VeryLazy",
    opts = {
      provider = "deepseek",
      vendors = {
        deepseek = {
          __inherited_from = "openai",
          api_key_name = "DEEPSEEK_API_KEY",
          endpoint = "https://api.deepseek.com",
          model = "deepseek-chat",
        },
      },
      file_selector = {
        provider = "snacks",
      },
    },
    build = build_cmd,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    optional = true,
    ft = { "markdown", "norg", "rmd", "org", "codecompanion", "Avante" },
  },
  {
    "HakonHarnes/img-clip.nvim",
    lazy = true,
    opts = {
      default = {
        embed_image_as_base64 = false,
        prompt_for_file_name = false,
        drag_and_drop = {
          insert_mode = true,
        },
        use_absolute_path = true,
      },
    },
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>a", group = "avante" },
      },
    },
  },
}

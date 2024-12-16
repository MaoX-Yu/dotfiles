return {
  {
    "yetone/avante.nvim",
    cond = not vim.g.vscode,
    version = false,
    event = { "BufReadPost", "BufNewFile" },
    cmd = {
      "AvanteAsk",
      "AvanteBuild",
      "AvanteChat",
      "AvanteChatNew",
      "AvanteClear",
      "AvanteEdit",
      "AvanteFocus",
      "AvanteHistory",
      "AvanteModels",
      "AvanteRefresh",
      "AvanteShowRepoMap",
      "AvanteStop",
      "AvanteSwitchProvider",
      "AvanteSwitchSelectorProvider",
      "AvanteToggle",
    },
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      provider = "deepseek",
      cursor_applying_provider = "deepseek",
      behaviour = {
        enable_cursor_planning_mode = true,
      },
      vendors = {
        deepseek = {
          __inherited_from = "openai",
          api_key_name = "DEEPSEEK_API_KEY",
          endpoint = "https://api.deepseek.com",
          model = "deepseek-chat",
          max_tokens = 8192,
        },
      },
      file_selector = {
        provider = "snacks",
      },
    },
  },
  {
    "HakonHarnes/img-clip.nvim",
    cond = not vim.g.vscode,
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
    "saghen/blink.cmp",
    dependencies = {
      "Kaiser-Yang/blink-cmp-avante",
    },
    opts = {
      sources = {
        default = { "avante" },
        providers = {
          avante = {
            module = "blink-cmp-avante",
            name = "Avante",
            async = true,
            score_offset = 100,
          },
        },
      },
    },
  },
}

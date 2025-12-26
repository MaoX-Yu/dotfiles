return {
  {
    "yetone/avante.nvim",
    cond = not vim.g.vscode,
    version = false,
    build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "AvanteBuild", "AvanteToggle" },
    opts = {
      provider = "deepseek",
      behaviour = {
        auto_set_highlight_group = false,
      },
      providers = {
        deepseek = {
          __inherited_from = "openai",
          api_key_name = "DEEPSEEK_API_KEY",
          endpoint = "https://api.deepseek.com",
          model = "deepseek-chat",
          max_tokens = 8192,
        },
      },
      selector = {
        provider = "snacks",
      },
      windows = {
        sidebar_header = {
          rounded = false,
        },
      },
      mappings = {
        ask = "<leader>Aa",
        new_ask = "<leader>An",
        zen_mode = "<leader>Az",
        edit = "<leader>Ae",
        refresh = "<leader>Ar",
        focus = "<leader>Af",
        stop = "<leader>AS",
        toggle = {
          default = "<leader>At",
          debug = "<leader>Ad",
          selection = "<leader>AC",
          suggestion = "<leader>As",
          repomap = "<leader>AR",
        },
        files = {
          add_current = "<leader>Ac",
          add_all_buffers = "<leader>AB",
        },
        select_model = "<leader>A?",
        select_history = "<leader>Ah",
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
}

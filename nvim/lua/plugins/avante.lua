P:add({
  "https://github.com/HakonHarnes/img-clip.nvim",
  {
    src = "https://github.com/yetone/avante.nvim",
    data = {
      cmd = { "AvanteBuild", "AvanteToggle" },
      event = { "BufReadPost", "BufNewFile" },
      config = function()
        require("img-clip").setup({
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            use_absolute_path = true,
          },
        })

        ---@diagnostic disable: missing-fields
        require("avante").setup({
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
            ask = "<Leader>Aa",
            new_ask = "<Leader>An",
            zen_mode = "<Leader>Az",
            edit = "<Leader>Ae",
            refresh = "<Leader>Ar",
            focus = "<Leader>Af",
            stop = "<Leader>AS",
            toggle = {
              default = "<Leader>At",
              debug = "<Leader>Ad",
              selection = "<Leader>AC",
              suggestion = "<Leader>As",
              repomap = "<Leader>AR",
            },
            files = {
              add_current = "<Leader>Ac",
              add_all_buffers = "<Leader>AB",
            },
            select_model = "<Leader>A?",
            select_history = "<Leader>Ah",
          },
        } --[[@as avante.Config]])
      end,
    },
  },
})

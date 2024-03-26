return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    optional = true,
    opts = {
      flavour = "macchiato",
      integrations = {
        fidget = true,
        lsp_saga = true,
        telescope = {
          enabled = true,
          style = "nvchad",
        },
      },
      styles = {
        conditionals = {},
        functions = { "italic" },
        properties = { "italic" },
        types = { "italic" },
      },
      custom_highlights = function(C)
        return {
          PmenuSbar = { bg = C.mantle },
          Visual = { bg = C.surface1, reverse = true, style = { "bold" } },
          VisualNOS = { bg = C.surface1, reverse = true, style = { "bold" } },

          -- lspsaga
          SagaBorder = { fg = C.mantle, bg = C.mantle },
          SagaNormal = { bg = C.mantle },
          SagaBeacon = { bg = C.mantle },

          -- which-key
          WhichKeyBorder = { fg = C.blue, bg = C.mantle },

          -- scrollview
          ScrollView = { bg = C.surface1 },

          -- nvim-cmp
          CmpItemAbbr = { fg = C.text },
          CmpItemMenu = { fg = C.mauve },
          CmpItemSel = { fg = C.mantle, bg = C.green, style = { "bold" } },
          CmpItemAbbrMatch = { fg = C.blue, style = { "bold" } },
          CmpItemAbbrMatchFuzzy = { fg = C.blue, style = { "bold" } },
          CmpItemKindSnippet = { fg = C.crust, bg = C.mauve },
          CmpItemKindKeyword = { fg = C.crust, bg = C.red },
          CmpItemKindText = { fg = C.crust, bg = C.teal },
          CmpItemKindMethod = { fg = C.crust, bg = C.blue },
          CmpItemKindConstructor = { fg = C.crust, bg = C.blue },
          CmpItemKindFunction = { fg = C.crust, bg = C.blue },
          CmpItemKindFolder = { fg = C.crust, bg = C.blue },
          CmpItemKindModule = { fg = C.crust, bg = C.blue },
          CmpItemKindConstant = { fg = C.crust, bg = C.peach },
          CmpItemKindField = { fg = C.crust, bg = C.green },
          CmpItemKindProperty = { fg = C.crust, bg = C.green },
          CmpItemKindEnum = { fg = C.crust, bg = C.green },
          CmpItemKindUnit = { fg = C.crust, bg = C.green },
          CmpItemKindClass = { fg = C.crust, bg = C.yellow },
          CmpItemKindVariable = { fg = C.crust, bg = C.flamingo },
          CmpItemKindFile = { fg = C.crust, bg = C.blue },
          CmpItemKindInterface = { fg = C.crust, bg = C.yellow },
          CmpItemKindColor = { fg = C.crust, bg = C.red },
          CmpItemKindReference = { fg = C.crust, bg = C.red },
          CmpItemKindEnumMember = { fg = C.crust, bg = C.red },
          CmpItemKindStruct = { fg = C.crust, bg = C.blue },
          CmpItemKindValue = { fg = C.crust, bg = C.peach },
          CmpItemKindEvent = { fg = C.crust, bg = C.blue },
          CmpItemKindOperator = { fg = C.crust, bg = C.blue },
          CmpItemKindTypeParameter = { fg = C.crust, bg = C.blue },
          CmpItemKindCopilot = { fg = C.crust, bg = C.teal },
        }
      end,
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = function()
      return {
        {
          "<leader>e",
          function()
            require("neo-tree.command").execute({ toggle = true, dir = require("lazyvim.util").root.get() })
          end,
          desc = "Explorer NeoTree (root dir)",
        },
        {
          "<leader>E",
          function()
            require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
          end,
          desc = "Explorer NeoTree (cwd)",
        },
        { "<leader>fe", "<cmd>Neotree focus<cr>", desc = "Focus on NeoTree", remap = true },
        { "<leader>fE", "<cmd>Neotree reveal<cr>", desc = "Find File in NeoTree", remap = true },
      }
    end,
  },
  {
    "dstein64/nvim-scrollview",
    event = "VeryLazy",
    config = function()
      require("scrollview").setup({
        excluded_filetypes = { "alpha", "dashboard" },
        current_only = true,
        column = 1,
        signs_on_startup = { "all" },
      })
    end,
  },
  {
    "gorbit99/codewindow.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local codewindow = require("codewindow")
      codewindow.setup()
      codewindow.apply_default_keybinds()
    end,
  },
  {
    "max397574/better-escape.nvim",
    event = "VeryLazy",
    opts = {
      mapping = { "jj", "fd" },
    },
  },
  {
    "kevinhwang91/nvim-ufo",
    event = "LazyFile",
    init = function()
      -- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep:│,foldclose:]]
      vim.o.foldcolumn = "1" -- '0' is not bad
      vim.o.foldenable = true
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
    end,
    opts = {
      preview = {
        mappings = {
          scrollB = "<C-b>",
          scrollF = "<C-f>",
          scrollU = "<C-u>",
          scrollD = "<C-d>",
        },
      },
      provider_selector = function(_, filetype, buftype)
        return (filetype == "" or buftype == "nofile") and "indent" -- only use indent until a file is opened
          or { "treesitter", "indent" } -- if file opened, try to use treesitter if available
      end,
    },
    -- stylua: ignore
    keys = {
      { "zR", function() require("ufo").openAllFolds() end,         desc = "Open All Folds" },
      { "zM", function() require("ufo").closeAllFolds() end,        desc = "Close All Folds" },
      { "zr", function() require("ufo").openFoldsExceptKinds() end, desc = "Fold less" },
      {
        "K",
        function()
          local winid = require("ufo").peekFoldedLinesUnderCursor()
          if not winid then
            -- vim.lsp.buf.hover()
            vim.cmd([[ Lspsaga hover_doc ]])
          end
        end,
        desc = "Hover",
      },
    },
    dependencies = {
      "kevinhwang91/promise-async",
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          local builtin = require("statuscol.builtin")
          require("statuscol").setup({
            relculright = true,
            ft_ignore = { "help", "vim", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
            segments = {
              {
                text = { builtin.foldfunc, " " },
                condition = { true, builtin.not_empty },
                click = "v:lua.ScFa",
              },
              {
                text = { builtin.lnumfunc, " " },
                condition = { true, builtin.not_empty },
                click = "v:lua.ScLa",
              },
              {
                text = { "%s" },
                click = "v:lua.ScSa",
              },
            },
          })
        end,
      },
    },
  },
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      progress = {
        suppress_on_insert = true,
        display = {
          render_limit = 8,
        },
      },
      notification = {
        window = {
          winblend = 100,
        },
      },
    },
  },
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      opts.lsp.progress = { enabled = false }
      return opts
    end,
  },
  {
    "onsails/lspkind.nvim",
    lazy = true,
  },
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
      window = {
        border = "single",
        position = "top",
      },
      defaults = {
        ["g"] = { name = "Goto" },
        ["gs"] = { name = "Surround" },
        ["z"] = { name = "Fold" },
        ["="] = { name = "Apply filter" },
        ["]"] = { name = "Next" },
        ["["] = { name = "Prev" },
        ["<C-w>"] = { name = "Window" },
        ["<leader>"] = { name = "Leader" },
        ["<leader>a"] = { name = "󰷉 Annotation" },
        ["<leader>b"] = { name = "󰓩 Buffer" },
        ["<leader>c"] = { name = " Code" },
        ["<leader>d"] = { name = " Debug" },
        ["<leader>f"] = { name = "󰈞 Find/File" },
        ["<leader>g"] = { name = "󰊢 Git" },
        ["<leader>gh"] = { name = "Hunks" },
        ["<leader>m"] = { name = " Minimap" },
        ["<leader>q"] = { "Quit all" },
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

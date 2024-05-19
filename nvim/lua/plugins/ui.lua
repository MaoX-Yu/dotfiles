return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    "folke/tokyonight.nvim",
    enabled = false,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    optional = true,
    opts = {
      flavour = "macchiato",
      integrations = {
        dropbar = {
          enabled = true,
          color_mode = false, -- enable color for kind's texts, not just kind's icons
        },
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
        return require("plugins.configs.catppuccin").highlights(C)
      end,
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function()
      return require("plugins.configs.lualine").opts()
    end,
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
          desc = "Explorer NeoTree (Root Dir)",
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
    "gorbit99/codewindow.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local codewindow = require("codewindow")
      codewindow.setup()
      codewindow.apply_default_keybinds()
    end,
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
      { "zR", function() require("ufo").openAllFolds() end,         desc = "Open All Folds"  },
      { "zM", function() require("ufo").closeAllFolds() end,        desc = "Close All Folds" },
      { "zr", function() require("ufo").openFoldsExceptKinds() end, desc = "Fold less"       },
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
        ["<leader>a"] = { name = "󰷉 Annotation" },
        ["<leader>b"] = { name = "󰓩 Buffer" },
        ["<leader>c"] = { name = " Code" },
        ["<leader>d"] = { name = " Debug" },
        ["<leader>f"] = { name = "󰈞 Find/File" },
        ["<leader>g"] = { name = "󰊢 Git" },
        ["<leader>gh"] = { name = "Hunks" },
        ["<leader>m"] = { name = " Minimap" },
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

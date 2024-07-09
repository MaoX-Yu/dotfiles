return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.core.view:visible() or vim.fn.pumvisible() == 1 then
            LazyVim.create_undo()
            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.core.view:visible() or vim.fn.pumvisible() == 1 then
            LazyVim.create_undo()
            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-o>"] = cmp.mapping(function(fallback)
          if has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
      })

      opts = vim.tbl_extend("force", opts, {
        window = {
          completion = {
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:CmpItemSel,Search:None",
            col_offset = -3,
            side_padding = 0,
            scrollbar = false,
          },
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(_, vim_item)
            local kind = vim_item.kind
            local symbol, _, _ = require("mini.icons").get("lsp", kind)
            vim_item.kind = " " .. (symbol or "󰞋") .. " "
            vim_item.menu = "    (" .. (kind or "Unknown") .. ")"
            return vim_item
          end,
        },
      })
      return opts
    end,
  },
}

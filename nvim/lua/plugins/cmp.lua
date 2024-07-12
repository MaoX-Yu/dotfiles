return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      local is_visible = function()
        return cmp.core.view:visible() or vim.fn.pumvisible() == 1
      end

      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if is_visible() then
            LazyVim.create_undo()
            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if is_visible() then
            LazyVim.create_undo()
            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
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

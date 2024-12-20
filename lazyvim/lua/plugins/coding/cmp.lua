return {
  {
    "iguanacucumber/magazine.nvim",
    name = "nvim-cmp",
    optional = true,
    dependencies = { "hrsh7th/cmp-emoji" },
    specs = {
      { "iguanacucumber/mag-nvim-lsp", name = "cmp-nvim-lsp", lazy = true },
      { "iguanacucumber/mag-buffer", name = "cmp-buffer", lazy = true },
    },
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
            winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
          },
        },
        formatting = {
          format = function(_, item)
            if item.kind == "FittenCode" then
              item.abbr = require("utils").fittencode.format(item.abbr)
            end
            item.abbr = item.abbr:gsub("…", "..")

            local symbol = MiniIcons.get("lsp", item.kind)
            item.kind = symbol .. "  " .. item.kind
            local widths = {
              abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
              menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
            }
            for key, width in pairs(widths) do
              if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
                item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "~"
              end
            end
            return item
          end,
        },
      })
      return opts
    end,
  },
  {
    "saghen/blink.cmp",
    optional = true,
    opts = {
      keymap = {
        preset = "super-tab",
        ["<CR>"] = { "accept", "fallback" },
      },
      completion = {
        menu = {
          draw = {
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
          },
        },
      },
      appearance = {
        kind_icons = {
          Fittencode = "󰘦 ",
        },
      },
    },
  },
}

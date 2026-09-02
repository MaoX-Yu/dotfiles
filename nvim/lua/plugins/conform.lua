P:add({
  {
    src = "https://github.com/stevearc/conform.nvim",
    data = {
      config = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        require("conform").setup({
          formatters_by_ft = {
            ["lua"] = { "stylua" },
            ["go"] = { "goimports" },
            ["markdown"] = { "prettier" },
            ["python"] = { "ruff_format" },
            ["vue"] = { "prettier" },
            ["javascript"] = { "prettier" },
            ["typescript"] = { "prettier" },
            ["json"] = { "prettier" },
          },
          default_format_opts = {
            lsp_format = "fallback",
          },
          format_on_save = function(bufnr)
            if vim.g.autoformat and (vim.b[bufnr].autoformat == nil or vim.b[bufnr].autoformat) then
              return { timeout_ms = 3000 }
            end
          end,
        })
        vim.api.nvim_create_user_command("Format", function(args)
          local range = nil
          if args.count ~= -1 then
            local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1] or ""
            range = {
              start = { args.line1, 0 },
              ["end"] = { args.line2, end_line:len() },
            }
          end
          require("conform").format({ async = true, lsp_format = "fallback", range = range })
        end, { range = true })
      end,
    },
  },
})

P.map({
  { "<Leader>cf", "<Cmd>Format<CR>", desc = "Format" },
})

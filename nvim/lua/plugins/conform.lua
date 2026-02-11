P:add({
  {
    src = "https://github.com/stevearc/conform.nvim",
    data = {
      cmd = { "Format", "ConformInfo" },
      event = { "BufWritePre" },
      config = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        require("conform").setup({
          formatters = {
            ["markdown-toc"] = {
              condition = function(_, ctx)
                for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
                  if line:find("<!%-%- toc %-%->") then
                    return true
                  end
                end
              end,
            },
            ["markdownlint-cli2"] = {
              condition = function(_, ctx)
                local diag = vim.tbl_filter(function(d)
                  return d.source == "markdownlint"
                end, vim.diagnostic.get(ctx.buf))
                return #diag > 0
              end,
            },
          },
          formatters_by_ft = {
            ["lua"] = { "stylua" },
            ["go"] = { "goimports" },
            ["markdown"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
            ["python"] = { "ruff_format" },
          },
          default_format_opts = {
            lsp_format = "fallback",
          },
          format_on_save = function(bufnr)
            if vim.g.autoformat and (vim.b[bufnr].autoformat or vim.b[bufnr].autoformat == nil) then
              return { timeout_ms = 3000 }
            end
          end,
        } --[[@as conform.setupOpts]])
        vim.api.nvim_create_user_command("Format", function(args)
          local range = nil
          if args.count ~= -1 then
            local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1] or ""
            range = {
              start = { args.line1, 0 },
              ["end"] = { args.line2, end_line:len() },
            }
          end
          require("conform").format({ async = true, lsp_format = "fallback", range = range } --[[@as conform.FormatOpts]])
        end, { range = true })

        P.map({
          { "Q", "<cmd>Format<cr>", desc = "Format" },
        })
      end,
    },
  },
})

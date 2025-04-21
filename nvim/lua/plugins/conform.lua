return {
  {
    "stevearc/conform.nvim",
    cond = not vim.g.vscode,
    event = { "BufWritePre" },
    cmd = { "Format", "ConformInfo" },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
      },
      default_format_opts = {
        lsp_format = "fallback",
      },
      format_on_save = function(bufnr)
        if vim.g.autoformat and (vim.b[bufnr].autoformat or vim.b[bufnr].autoformat == nil) then
          return { timeout_ms = 3000 }
        end
      end,
    },
    config = function(_, opts)
      require("conform").setup(opts)
      vim.api.nvim_create_user_command("Format", function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
          }
        end
        require("conform").format({ async = true, lsp_format = "fallback", range = range })
      end, { range = true })
    end,
    keys = {
      { "Q", "<cmd>Format<cr>", desc = "Format" },
    },
  },
}

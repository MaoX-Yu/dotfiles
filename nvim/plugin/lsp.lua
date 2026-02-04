vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  virtual_text = {
    current_line = false,
    spacing = 4,
    source = "if_many",
  },
  virtual_lines = {
    current_line = true,
  },
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = " ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
} --[[@as vim.diagnostic.Opts]])

vim.lsp.inlay_hint.enable()

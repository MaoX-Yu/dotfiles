return {
  name = "run python (back)",
  condition = {
    filetype = { "python" },
  },
  builder = function()
    return {
      name = vim.fn.expand("%:t"),
      cmd = "python",
      cwd = vim.fn.expand("%:p:h"),
      args = { vim.fn.expand("%:p") },
      components = { "default" },
    }
  end,
}

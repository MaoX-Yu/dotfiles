return {
  generator = function()
    return {
      {
        name = "run python",
        builder = function()
          return {
            name = vim.fn.expand("%:t"),
            cmd = "python",
            cwd = vim.fn.expand("%:p:h"),
            args = { vim.fn.expand("%:p") },
            components = {
              { "open_output", direction = "float", focus = true, on_start = "always" },
              "default",
            },
          }
        end,
      },
      {
        name = "run python (back)",
        builder = function()
          return {
            name = vim.fn.expand("%:t"),
            cmd = "python",
            cwd = vim.fn.expand("%:p:h"),
            args = { vim.fn.expand("%:p") },
            components = { "default" },
          }
        end,
      },
    }
  end,
  condition = {
    filetype = { "python" },
  },
}

local M = {}

function M.super_escape()
  vim.snippet.stop()
  return "<cmd>noh<cr><esc>"
end

function M.super_q()
  if vim.bo.bt == "terminal" then
    return "<cmd>close<cr>"
  end
  return "@"
end

return M

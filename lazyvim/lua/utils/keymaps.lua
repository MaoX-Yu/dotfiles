local M = {}

function M.super_q()
  if vim.bo.bt ~= "" then
    return "<cmd>close<cr>"
  end
  return "@"
end

return M

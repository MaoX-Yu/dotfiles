local M = {}

function M.super_q()
  if vim.bo.bt ~= "" then
    return "<cmd>close<cr>"
  end
  return "q"
end

function M.virt_lines()
  local flag = type(vim.diagnostic.config().virtual_lines) == "table"
  if flag then
    vim.diagnostic.config({ virtual_lines = false })
  else
    vim.diagnostic.config({ virtual_lines = { current_line = true } })
  end
end

return M

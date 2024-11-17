---Statuscolumn utils
local M = {}

function M.is_fold_start(line)
  if vim.v.virtnum ~= 0 then
    return false
  end

  return tostring(vim.treesitter.foldexpr(line)):sub(1, 1) == ">"
    and vim.treesitter.foldexpr(line + 1) ~= vim.treesitter.foldexpr(line)
end

return M

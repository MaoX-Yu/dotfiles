local M = {}

function M.format(str)
  if str and vim.trim(str) == "<\\n>" then
    return "<CR>~"
  end

  local res = "~"
  for s in vim.gsplit(str, "<\\n>", { plain = true, trimempty = true }) do
    if s and s ~= "" then
      res = vim.trim(s) .. "~"
      break
    end
  end
  return res
end

return M

---@class KeymapUtils
local M = {}

function M.super_escape()
  vim.cmd("noh")
  vim.snippet.stop()
  return "<esc>"
end

function M.super_q()
  if vim.bo.bt ~= "" then
    return "<cmd>close<cr>"
  end
  return "q"
end

return M

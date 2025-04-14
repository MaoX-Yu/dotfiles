local o = vim.opt

local M = {}

function M.setup()
  if vim.fn.executable("nu") == 1 then
    o.shell = "nu"
    o.shellcmdflag = "--stdin --no-newline -c"
    o.shellpipe = "out+err> %s"
    o.shellredir = "out+err> %s"
    o.shellxescape = ""
    o.shellquote = ""
    o.shellxquote = ""
    o.shelltemp = false
  elseif LazyVim.is_win() then
    LazyVim.terminal.setup("pwsh")
  end
end

return M

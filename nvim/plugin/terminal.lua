local o = vim.o

if not vim.uv.os_uname().sysname:find("Windows") then
  return
end

if vim.fn.executable("nu") == 1 then
  o.shell = "nu"
  o.shellcmdflag = "--stdin --no-newline -c"
  o.shellpipe =
    "| complete | update stderr { ansi strip } | tee { if ($in.stderr | is-empty) { get stdout } else { get stderr } | save --force --raw %s } | into record"
  o.shellredir = "out+err> %s"
  o.shellxescape = ""
  o.shellquote = ""
  o.shellxquote = ""
  o.shelltemp = false

  return
end

if vim.fn.executable("pwsh") == 1 then
  o.shell = "pwsh"
else
  o.shell = "powershell"
end
o.shellcmdflag =
  "-NoLogo -NonInteractive -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';$PSStyle.OutputRendering='plaintext';Remove-Alias -Force -ErrorAction SilentlyContinue tee;"
o.shellpipe = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
o.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
o.shellquote = ""
o.shellxquote = ""

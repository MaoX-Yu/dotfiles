vim.filetype.add({
  filename = {
    ["git"] = "gitconfig",
    ["lazygit"] = "yaml",
    ["powershell"] = "ps1",
    ["starship"] = "toml",
  },
})

local library = vim
  .iter(vim.pack.get(nil, { info = false }))
  :map(function(plug)
    return plug.path
  end)
  :filter(function(path)
    return vim.uv.fs_stat(path) ~= nil
  end)
  :totable()

table.insert(library, 1, vim.env.VIMRUNTIME)

vim.lsp.config("emmylua_ls", {
  settings = {
    emmylua = {
      workspace = { library = library },
    },
  },
})

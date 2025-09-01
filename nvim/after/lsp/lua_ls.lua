return {
  settings = {
    Lua = {
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = "Disable",
      },
      codeLens = {
        enable = true,
      },
      completion = {
        callSnippet = "Replace",
      },
      doc = {
        privateName = { "^_" },
      },
      hint = {
        enable = true,
        arrayIndex = "Auto",
        paramName = "All",
        paramType = true,
        setType = true,
      },
    },
  },
}

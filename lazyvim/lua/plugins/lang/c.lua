if not LazyVim.has_extra("lang.clangd") then
  return {}
end

return {
  {
    "williamboman/mason.nvim",
    optional = true,
    opts = { ensure_installed = { "clang-format" } },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        ["c"] = { "clang-format" },
        ["cpp"] = { "clang-format" },
      },
    },
  },
}

local config = vim.tbl_deep_extend(
  "force",
  {},
  require("core.snacks.editor"),
  require("core.snacks.indent"),
  require("core.snacks.ui")
)

return config

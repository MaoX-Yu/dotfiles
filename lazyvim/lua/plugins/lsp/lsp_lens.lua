return {
  {
    "VidocqH/lsp-lens.nvim",
    event = "LazyFile",
    opts = {
      enable = true,
      include_declaration = false, -- Reference include declaration
      sections = { -- Enable / Disable specific request
        definition = false,
        references = true,
        implements = true,
      },
      ignore_filetype = {
        "prisma",
      },
    },
  },
}

if not LazyVim.has_extra("lang.rust") then
  return {}
end

return {
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        taplo = {
          keys = {
            {
              "K",
              function()
                local winid = require("ufo").peekFoldedLinesUnderCursor()
                if not winid then
                  if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
                    require("crates").show_popup()
                  else
                    vim.lsp.buf.hover()
                  end
                end
              end,
              desc = "Hover",
            },
          },
        },
      },
    },
  },
}

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
                if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
                  require("crates").show_popup()
                else
                  -- vim.lsp.buf.hover()
                  vim.cmd([[ Lspsaga hover_doc ]])
                end
              end,
              desc = "Show Crate Documentation",
            },
          },
        },
      },
    },
  },
}

P:add({
  {
    src = "https://github.com/mason-org/mason.nvim",
    data = {
      config = function()
        require("mason").setup({
          ui = {
            icons = {
              package_installed = "✓",
              package_uninstalled = "✗",
              package_pending = "⟳",
            },
          },
        })

        local Result = require("mason-core.result")
        local path = require("mason-core.path")
        local compiler = require("mason-core.installer.compiler")
        local pypi = require("mason-core.installer.compiler.compilers.pypi")

        local extend = { __index = pypi }

        local uv = {
          ---@async
          ---@param ctx InstallContext
          ---@param source ParsedPypiSource
          install = function(ctx, source)
            -- Note that this implementation will always try to use uv and not fall back to default.
            -- Uncomment the following for a default fallback.
            -- if vim.fn.executable "uv" ~= 1 then
            --   return pypi.install(ctx, source)
            -- end
            return Result.try(function(try)
              ctx:promote_cwd()
              try(ctx.spawn.uv({ "venv", "venv" }))
              try(ctx.spawn.uv({
                "pip",
                "install",
                source.extra and ("%s[%s]==%s"):format(source.package, source.extra, source.version)
                  or ("%s==%s"):format(source.package, source.version),
                source.extra_packages or vim.NIL,
                env = {
                  VIRTUAL_ENV = path.concat({ ctx.cwd:get(), "venv" }),
                },
              }))
            end)
          end,
        }

        setmetatable(uv, extend)

        compiler.register_compiler("pypi", uv)
      end,
    },
  },
})

P.map({
  { "<Leader>cm", "<Cmd>Mason<CR>", desc = "Mason" },
})

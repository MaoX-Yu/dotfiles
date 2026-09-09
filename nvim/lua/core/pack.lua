local Pack = require("utils.pack")

_G.P = Pack.new()

-- Theme
require("plugins.catppuccin")

-- Tools
require("plugins.snacks")
require("plugins.mini")

-- Deps
require("plugins.friendly-snippets")
require("plugins.nui")
require("plugins.plenary")
require("plugins.schemastore")

--- LSP
require("plugins.lspconfig")
require("plugins.mason")

-- Treesitter
require("plugins.treesitter")

-- Code
require("plugins.blink")
require("plugins.conform")
require("plugins.dial")
require("plugins.guess-indent")
require("plugins.lint")
require("plugins.rainbow-bracket")

-- Editor
require("plugins.dap")
require("plugins.diffs")
require("plugins.gitsigns")
require("plugins.neogit")
require("plugins.overseer")
require("plugins.persistence")
require("plugins.render-markdown")
require("plugins.telescope")
require("plugins.which-key")
require("plugins.yanky")

-- Lang
require("plugins.lang.go")
require("plugins.lang.python")
require("plugins.lang.rust")

P:load()

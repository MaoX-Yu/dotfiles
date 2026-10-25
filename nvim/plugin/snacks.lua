-- Local adaptation of selected snacks.nvim modules.
-- Upstream: https://github.com/folke/snacks.nvim
-- See nvim/lua/utils/snacks/ATTRIBUTION.md for version and license details.

local S = require("utils.snacks")

S.setup(require("core.snacks"))
require("core.snacks.toggles").setup()
require("core.snacks.keymaps").setup()

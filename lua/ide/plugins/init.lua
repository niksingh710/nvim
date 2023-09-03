require("ide.plugins.lazy")
require("ide.plugins.theme")

---@diagnostic disable-next-line: lowercase-global
wstatus, whichkey = pcall(require, "which-key")

require("ide.plugins.telescope")
require("ide.plugins.nvim-tree")
require("ide.plugins.treesitter")
require("ide.plugins.alpha")
require("ide.plugins.persisted")
require("ide.plugins.bufferline")
require("ide.plugins.lsp")
require("ide.plugins.cmp")
require("ide.plugins.lualine")
require("ide.plugins.noice")
require("ide.plugins.firenvim")
require("ide.plugins.copilot")

-- require("ide.plugins.formatter")
-- require("ide.plugins.linter")

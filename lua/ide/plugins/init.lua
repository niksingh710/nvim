-- Example for configuring Neovim to load user-installed installed Lua rocks:
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"

vim.g.vimwiki_list = {
	{ path = "~/.vimwiki/", syntax = "markdown", ext = ".md" },
}
vim.g.vimwiki_global_ext = 0

require("ide.plugins.lazy")
require("ide.plugins.theme")

---@diagnostic disable-next-line: lowercase-global
wstatus, whichkey = pcall(require, "which-key")
-- if pcall(require, "notify") then
-- 	vim.notify = require("notify")
-- end

require("ide.plugins.noice")
require("ide.plugins.telescope")
require("ide.plugins.nvim-tree")
require("ide.plugins.alpha")
require("ide.plugins.persisted")
require("ide.plugins.bufferline")
require("ide.plugins.lang")
require("ide.plugins.lualine")
require("ide.plugins.firenvim")
require("ide.plugins.copilot")
require("ide.plugins.whichkey")

-- require("ide.plugins.formatter")
-- require("ide.plugins.linter")

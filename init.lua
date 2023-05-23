vim.loader.enable()
require("niksingh710.utils")   -- Loads the utility functions required in the whole config
require("niksingh710.icons")   -- Loads the utility functions required in the whole config
require("niksingh710.colors")  -- Loads the utility functions required in the whole config

require("niksingh710.options") -- Loads options for neovim e.g set number ... etc
require("niksingh710.mappings")
require("niksingh710.autocmds")

local list = srequire("niksingh710.list") -- Storing plugins array in global variable
if not list then
  return
end
require("niksingh710.plugins").load(list)
require("niksingh710.themes") -- The theme is from a plugin

require("niksingh710.whichkey")
require("niksingh710.bufferline")
require("niksingh710.lualine")
require("niksingh710.telescope")
require("niksingh710.nvim-tree")
require("niksingh710.treesitter")
require("niksingh710.indentline")

require("niksingh710.alpha")

require("niksingh710.markdown")
require("niksingh710.general")

require("niksingh710.lsp.lspsaga")
require("niksingh710.lsp.cmp")
require("niksingh710.lsp.null-ls")
require("niksingh710.lsp")
require("niksingh710.gitsigns")
vim.keymap.set("i", "<esc>", "<esc>", { noremap = true, silent = true }) --fall back protections

-- Bootstraping lazy.nvim{{{
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- }}}

local opts = {
  ui = {
    -- border = "rounded",
    border = "single",
  },
  install = {
    colorscheme = { -- Will try to load the themes if available in this order
      "tokyodark",
      "catppuccin",
      "material",
      "tokyonight",
    },
  },
}

local list = utils.filter(require "niksingh710.plugins.list")
require("lazy").setup(list, opts)

utils.map("n", {
  ["<leader>L"] = { "<cmd>Lazy<cr>", "Lazy Plugin Manager" },
})

require "niksingh710.plugins.themes"

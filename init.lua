vim.cmd("colorscheme habamax")

-- Global variables to be used
border = "rounded"
---@diagnostic disable-next-line: lowercase-global
icons = require("core.icons")
utils = require("core.utils")

require("core.options")
require("core.mappings")
require("core.autocmds")

lang = require("lang")

-- Plugin manager
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

local opts = {
  ui = {
    border = border or "rounded",
    icons = icons.ui.lazy,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "matchit",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
      },
    },
  },
  change_detection = { enabled = false },
  defaults = {
    lazy = true,
  },
  install = {
    colorscheme = { -- Will try to load the themes if available in this order
      "tokyodark",
      "material",
      "catppuccin",
      "tokyonight",
      "habmax",
    },
  },
}

require("lazy").setup({
  { import = "plugins" },
  { import = "plugins.languages" },
}, opts) -- importing will allow to have all the files in the dir as plugin

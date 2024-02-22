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
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
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
      "tokyonight",
      "catppuccin",
      "habamax",
    },
  },
}

require("lazy").setup({
  { import = "plugins" },
  { import = "plugins.languages" },
  { import = "plugins.themes" },
}, opts) -- importing will allow to have all the files in the dir as plugin

vim.keymap.set("n", "<leader>iL", "<cmd>Lazy<CR>", { noremap = true, silent = true })

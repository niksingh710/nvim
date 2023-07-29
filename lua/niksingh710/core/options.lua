-- Options for general vim settings and a few advance one with neovim support
-- These options are available throughout the config 
local opts = {
  backup = false,
  cmdheight = 1,
  completeopt = { "menuone", "noselect" },
  fileencoding = "utf-8",
  hlsearch = true,
  pumheight = 10,
  showmode = false,
  ruler = false,
  so = 999,
  autoread = true,
  showtabline = 2,
  smartindent = true,
  swapfile = false,
  writebackup = false,
  numberwidth = 4,
  wrap = true,
  linebreak = true,
  scrolloff = 8,
  sidescrolloff = 8,
  whichwrap = "bs<>[]hl",
  relativenumber = true,
  number = true,
  tabstop = 2,
  shiftwidth = 2,
  smarttab = true,
  expandtab = true,
  autoindent = true,
  ignorecase = true,
  smartcase = true,
  incsearch = true,
  cursorline = false,
  background = "dark",
  signcolumn = "yes",
  splitbelow = true,
  splitright = true,
  foldmethod = "marker",
  foldenable = false,
  list = true,
  softtabstop = 2,
  termguicolors = true,
  syntax = "on",
  undofile = true,
  updatetime = 250,
  timeoutlen = 300,
  timeout = true,
  breakindent = true,
  mouse = "a",
  fillchars = { eob = " " },
  spell = false,
  spelllang = { "en_us" },
  shortmess = "csCFW",
  showcmd = false,
  hidden = true,
  title = true,
  laststatus = 2,
  conceallevel = 3,
  autochdir = true,
  wildoptions = "fuzzy",
  cmdwinheight = 1,
}

local o = vim.opt

for k, v in pairs(opts) do
  vim.opt[k] = v
end

vim.opt.wildcharm = ("\t"):byte()     -- so that tab key can be remapped

o.clipboard:append("unnamedplus")
-- o.undodir = os.getenv("HOME") .. "/.vim/undodir"
o.iskeyword:append("-")
o.listchars:append("space:·")
o.fillchars:append('fold:•')

vim.g.floating_window_options = {
  border = "rounded",
  winblend = 10,
}
vim.opt.completeopt:append("noinsert")
vim.g.lsp_async_completion = true

-- They should only contain a plugin property if the property is not dependent on plugin
vim.cmd([[
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
]])

-- Options for general vim settings and a few advance one with neovim support
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
  -- guifont = "monospace:h17",
  whichwrap = "bs<>[]hl",
  relativenumber = true,
  number = true,
  tabstop = 2,
  shiftwidth = 2,
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
  list = false,
  softtabstop = 4,
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
  shortmess = "a",
  showcmd = false,
  hidden = true,
  title = true,
  laststatus = 3,
  conceallevel = 2,
  autochdir = true,
  wildoptions = "fuzzy",
  cmdwinheight = 1,
  -- shell = "/usr/bin/bash",
}

local o = vim.opt

for k, v in pairs(opts) do
  vim.opt[k] = v
end

o.clipboard:append("unnamedplus")
-- o.undodir = os.getenv("HOME") .. "/.vim/undodir"
o.iskeyword:append("-")
o.listchars:append("space:·")

vim.g.floating_window_options = {
  border = "rounded",
  winblend = 10,
}
vim.opt.completeopt:append("noinsert")
vim.g.lsp_async_completion = true

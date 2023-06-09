vim.g.mapleader = " "
vim.g.maplocalleader = " "

local insert = {
  ["jk"] = "<esc>",
  ["kj"] = "<esc>",
  ["<esc>"] = "<esc>", -- don't know why but somehow escape is unmapped to <esc> in my system.
  ["<c-s>"] = "<esc>:w<cr>",
  ["<a-j>"] = "<esc>:m .+1<cr>==gi",
  ["<a-k>"] = "<esc>:m .-2<cr>==gi",
}

local normal = {
  ["<c-s>"] = ":w<cr>",
  ["<a-j>"] = ":m .+1<cr>==",
  ["<a-k>"] = ":m .-2<cr>==",
  ["<leader>q"] = { ":quit!<cr>", "Quit!" },
  ["<leader>c"] = { ":bd!<cr>", "Close!" },
  ["<leader>h"] = { ":nohl<cr>", "No Highlight!" },
  ["<leader>a"] = { "gg0vG$", "Select All" },
  ["<s-h>"] = ":bprevious<cr>",
  ["<s-l>"] = ":bnext<cr>",
  ["<c-a-k>"] = ":resize -2<cr>",
  ["<c-a-j>"] = ":resize +2<cr>",
  ["<c-a-l>"] = ":vertical resize -2<cr>",
  ["<c-a-h>"] = ":vertical resize +2<cr>",
  ["<c-h>"] = "<c-w>h",
  ["<c-j>"] = "<c-w>j",
  ["<c-k>"] = "<c-w>k",
  ["<c-l>"] = "<c-w>l",
  ["<leader>u"] = { ":UndotreeToggle<cr>", "Undo Tree"},
  -- highlight are in center
  ["n"] = "nzzzv",
  ["N"] = "Nzzzv",
  ["x"] = '"_x',
  -- ["j"] = "jzz",
  -- ["k"] = "kzz",
}
local visual = {
  ["<c-s>"] = "<esc>:w<cr>",
  ["<c-c>"] = "<esc>",
  ["<a-j>"] = ":m '>+1<cr>gv-gv",
  ["<a-k>"] = ":m '<lt>-2<CR>gv-gv",
  ["<"] = "<gv",
  [">"] = ">gv",
  ["<space>"] = "<Nop>",
  ["x"] = '"_x',
  ["p"] = '"_dP',
  ["P"] = '"_dP',
  -- ["J"] = ":m '>+1<cr>gv-gv",
  -- ["K"] = ":m '<lt>-2<CR>gv-gv",
  ["j"] = "jzz",
  ["k"] = "kzz",
  ["<leader>y"] = '"+y',
  ["<leader>d"] = '"+d',
  ["<leader>Y"] = 'gg"+yG',
  ["<leader>D"] = 'gg"+dG',
  ["<leader>x"] = '"+x',
  ["<leader>X"] = '"+',
}

map("i", insert)
map("n", normal)
map("x", visual)


-- mapping for the vim command prompt
vim.opt.wildcharm = ("\t"):byte()
vim.keymap.set("c", "<C-j>", "<Tab>", {})
vim.keymap.set("c", "<C-k>", "<s-Tab>", {})

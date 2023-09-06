-- This file is my mappings for neovim using the fn from the utils file.
-- keeping the ensurity that none mapping is plugin dependent in this file.

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = utils.map

local normal = {
	["<c-s>"] = { "<cmd>w<cr>", "Save the file" },
	["<c-h>"] = { "<c-w>h", "Focus on right split" },
	["<c-j>"] = { "<c-w>j", "Focus on below split" },
	["<c-k>"] = { "<c-w>k", "Focus on up split" },
	["<c-l>"] = { "<c-w>l", "Focus on left split" },
	["<c-a-j>"] = { ":resize -1<cr>", "Resize down" },
	["<c-a-k>"] = { ":resize +1<cr>", "Resize up" },
	["<c-a-l>"] = { ":vertical resize -1<cr>", "Resize right" },
	["<c-a-h>"] = { ":vertical resize +1<cr>", "Resize left" },
	["<c-a-=>"] = { "<C-a>", "Increase Number" },
	["<c-a-->"] = { "<C-x>", "Decrease Number" },

	["<a-j>"] = { ":m .+1<cr>==", "Move line Down" },
	["<a-k>"] = { ":m .-2<cr>==", "Move line up" },

	["<s-h>"] = { ":bprevious<cr>", "Buffer Previous" },
	["<s-l>"] = { ":bnext<cr>", "Buffer Next" },

	["<leader>q"] = { ":quit!<cr>", "Quit!" },
	["<leader><cr>"] = { utils.set_curdir, "Ch Dir!" },
	-- ["<leader>c"] = { ":bd!<cr>", "Close!" },
	["<leader>c"] = { "<cmd>lua utils.close_buffer()<cr>", "Close!" }, -- Custom fn to ensure if this is the last buffer then quit nvim
	["<leader>h"] = { ":nohl<cr>", "No Highlight!" },
	["<leader>a"] = { "gg0vG$", "Select All" },
	["<leader>vv"] = { "<cmd>vsplit<cr>", "vertical split" },
	["<leader>vs"] = { "<cmd>split<cr>", "horizontal split" },
	["<leader>tj"] = { "<cmd>tabn<cr>", "Next Tab" },
	["<leader>tk"] = { "<cmd>tabp<cr>", "Previous Tab" },
	["<leader>tl"] = { "<cmd>tabn<cr>", "Next Tab" },
	["<leader>th"] = { "<cmd>tabp<cr>", "Previous Tab" },

	["<leader>tq"] = { "<cmd>tabclose<cr>", "Close Tab" },
	["<leader>tn"] = { "<cmd>tabnew<cr>", "New Tab" },

	---@diagnostic disable-next-line: undefined-global
	["<leader><leader>"] = { utils.filetypeSet, "Set Filetype" },

	-- highlight are in center
	["n"] = "nzzzv",
	["N"] = "Nzzzv",
	["x"] = '"_x',
}

local insert = { -- as these are insert mode mapping they don't need descriptions
	["jk"] = "<esc>",
	-- ["kj"] = "<esc>",
	["<esc>"] = "<esc>", -- Copilot unmaps esc in insert mode
	["<c-s>"] = "<esc>:w<cr>",
	["<a-j>"] = "<esc>:m .+1<cr>==gi",
	["<a-k>"] = "<esc>:m .-2<cr>==gi",
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

	["<leader>y"] = '"+y',
	["<leader>d"] = '"+d',
	["<leader>Y"] = 'gg"+yG',
	["<leader>D"] = 'gg"+dG',
	["<leader>x"] = '"+x',
	["<leader>X"] = '"+',
}
map("n", normal)
map("i", insert)
map("x", visual)

local movement = {
  ["j"] = "v:count ? 'j' : 'gj'",
  ["k"] = "v:count ? 'k' : 'gk'",
}

map("n", movement, { expr = true })
map("x", movement, { expr = true })

vim.keymap.set("c", ":", "q:", {})
vim.keymap.set("n", ":", "q:i", {})
vim.keymap.set("c", "<c-j>", "<Tab>", {})
vim.keymap.set("c", "<c-k>", "<s-Tab>", {})

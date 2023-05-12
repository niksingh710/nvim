local treesitter = srequire("nvim-treesitter.configs")
if not treesitter then
	return
end

treesitter.setup({
	-- Add languages to be installed here that you want installed for treesitter
	ensure_installed = { "c", "cpp", "go", "lua", "python", "rust", "tsx", "typescript", "vimdoc", "vim" },
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
		config = {
			-- Languages that have a single comment style
			typescript = "// %s",
			css = "/* %s */",
			scss = "/* %s */",
			html = "<!-- %s -->",
			svelte = "<!-- %s -->",
			vue = "<!-- %s -->",
			json = "",
		},
	},
	textsubjects = {
		enable = false,
		keymaps = { ["."] = "textsubjects-smart", [";"] = "textsubjects-big" },
	},
	playground = {
		enable = true,
	},
	rainbow = {
		enable = true,
		extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
		max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
	},
	-- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
	auto_install = true,
	highlight = { enable = true },
	indent = {
		enable = true,
		-- disable = { "python" }
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-n>",
			node_incremental = "<C-n>",
			scope_incremental = "<C-s-s>",
			node_decremental = "<C-p>",
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
		--swap = {
		-- enable = true,
		--swap_next = {
		-- ['<leader>a'] = '@parameter.inner',
		--},
		--swap_previous = {
		-- ['<leader>A'] = '@parameter.inner',
		--},
		-- },
	},
})
vim.cmd([[
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable                     " Disable folding at startup.
]])

local tree = srequire("tree-climber")
if not tree then
	return
end
local mappings = {
	["<a-H>"] = { tree.goto_parent, "Parent node" },
	["<a-L>"] = { tree.goto_child, "Child node" },
	["<a-J>"] = { tree.goto_next, "Next node" },
	["<a-K>"] = { tree.goto_prev, "Previous node" },
	["<c-s-h>"] = tree.highlight_node,
}
local mappingsV = {
	["H"] = { tree.goto_parent, "Parent node" },
	["L"] = { tree.goto_child, "Child node" },
	["J"] = { tree.goto_next, "Next node" },
	["K"] = { tree.goto_prev, "Previous node" },
	["<c-s-h>"] = tree.highlight_node,
}
map("n", mappings)
map("x", mappings)

-- vim.keymap.set({ "n", "v", "o" }, "H", require("tree-climber").goto_parent, keyopts)
-- vim.keymap.set({ "n", "v", "o" }, "L", require("tree-climber").goto_child, keyopts)
-- vim.keymap.set({ "n", "v", "o" }, "J", require("tree-climber").goto_next, keyopts)
-- vim.keymap.set({ "n", "v", "o" }, "K", require("tree-climber").goto_prev, keyopts)
-- vim.keymap.set({ "v", "o" }, "in", require("tree-climber").select_node, keyopts)
-- vim.keymap.set("n", "<c-k>", require("tree-climber").swap_prev, keyopts)
-- vim.keymap.set("n", "<c-j>", require("tree-climber").swap_next, keyopts)
-- vim.keymap.set("n", "<c-h>", require("tree-climber").highlight_node, keyopts)

local tok, treesitter = pcall(require, "nvim-treesitter.configs")
if not tok then
	return
end

local opts = {
	ensure_installed = config.treesitter_ensure or {},
	auto_install = true,
	highlight = {
		enable = true,
		use_languagetree = true,
	},

	indent = { enable = true },
}

treesitter.setup(opts)

local tiok, treesitter_select = pcall(require, "treesitter_indent_object")
if tiok then
	treesitter_select.setup()

	vim.keymap.set({ "x", "o" }, "ai", "<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_outer()<CR>")
	-- ensure selecting entire line (or just use Vai)
	vim.keymap.set(
		{ "x", "o" },
		"aI",
		"<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_outer(true)<CR>"
	)
	-- select inner block (only if block, only else block, etc.)
	vim.keymap.set({ "x", "o" }, "ii", "<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_inner()<CR>")
	-- select entire inner range (including if, else, etc.)
	vim.keymap.set(
		{ "x", "o" },
		"iI",
		"<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_inner(true)<CR>"
	)
end

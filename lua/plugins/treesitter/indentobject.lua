return {
				"kiyoon/treesitter-indent-object.nvim",
        enabled = config.treesitter_indent_object,
        lazy = false,
        keys = {
          { "ai", "<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_outer()<CR>",mode = {"x","o"},desc = "slect indent outer"},
	-- ensure selecting entire line (or just use Vai)
		{ "aI", "<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_outer(true)<CR>",mode = {"x","o"},desc="select indent Outer"},
	-- select inner block (only if block, only else block, etc.)
	{ "ii", "<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_inner()<CR>",mode = {"x","o"},desc="select indent inner"},
	-- select entire inner range (including if, else, etc.)
		{ "iI", "<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_inner(true)<CR>",mode = {"x","o"},desc = "select indent Inner " },
        },
  }

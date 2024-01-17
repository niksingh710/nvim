M = {}
M.config = function()
	local opts = {
		ensure_installed = {},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<leader>..", -- set to `false` to disable one of the mappings
				node_incremental = "<leader>.i",
				scope_incremental = "<leader>.c",
				node_decremental = "<leader>.d",
			},
		},
		auto_install = true,
		highlight = {
			enable = true,
			use_languagetree = true,
		},
		indent = true,
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
					-- You can optionally set descriptions to the mappings (used in the desc parameter of
					-- nvim_buf_set_keymap) which plugins like which-key display
					["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
					-- You can also use captures from other query groups like `locals.scm`
					["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
				},
				selection_modes = {
					["@parameter.outer"] = "v", -- charwise
					["@function.outer"] = "v", -- linewise
					["@class.outer"] = "<c-v>", -- blockwise
				},
			},
		},
		textsubjects = {
			enable = true,
			prev_selection = ",", -- (Optional) keymap to select the previous selection
			keymaps = {
				["."] = "textsubjects-smart",
				[";"] = "textsubjects-container-outer",
				["i;"] = {
					"textsubjects-container-inner",
					desc = "Select inside containers (classes, functions, etc.)",
				},
			},
		},
	}
	require("nvim-treesitter.configs").setup(opts)
end

M.blankline_config = function()
	local config = require("ibl.config").default_config
	config.scope.show_start = false
	local highlight = {
		"RainbowRed",
		"RainbowYellow",
		"RainbowBlue",
		"RainbowOrange",
		"RainbowGreen",
		"RainbowViolet",
		"RainbowCyan",
	}
	local hooks = require("ibl.hooks")
	-- create the highlight groups in the highlight setup hook, so they are reset
	-- every time the colorscheme changes
	hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
		vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
		vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
		vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
		vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
		vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
		vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
		vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
	end)

	vim.g.rainbow_delimiters = { highlight = highlight }
	config.scope.highlight = highlight
	require("ibl").setup(config)

	hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

	config.indent.tab_char = config.indent.char
	require("ibl").setup(config)
end

return M

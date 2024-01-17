local M = {}

M.persisted = function()
	local persisted = require("persisted")
	local rtimedir = os.getenv("XDG_RUNTIME_DIR")
	local opts = {
		autosave = true,
		use_git_branch = false,
		default_branch = "master",
		follow_cwd = true,
		should_autosave = function()
			-- do not autosave if the alpha dashboard is the current filetype
			if vim.bo.filetype == "alpha" or vim.bo.filetype == "" or vim.bo.filetype == "NvimTree" then
				return false
			end
			return true
		end,
		ignored_dirs = {
			rtimedir .. "/firenvim",
		},
	}
	persisted.setup(opts)
end

M.config = function()
	local action = require("telescope.actions")
	local telescope = require("telescope")

	local opts = {
		extensions = {
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case",
			},
			undo = {
				mappings = {
					n = {
						-- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
						-- you want to replicate these defaults and use the following actions. This means
						-- installing as a dependency of telescope in it's `requirements` and loading this
						-- extension from there instead of having the separate plugin definition as outlined
						-- above.
						["y"] = require("telescope-undo.actions").yank_additions,
						["Y"] = require("telescope-undo.actions").yank_deletions,
						["<cr>"] = require("telescope-undo.actions").restore,
					},
				},
				side_by_side = true,
				layout_strategy = "vertical",
				layout_config = {
					preview_height = 0.8,
				},
			},
		},

		defaults = {
			vimgrep_arguments = {
				"rg",
				"-L",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
			},
			prompt_prefix = "   ",
			selection_caret = "  ",
			entry_prefix = "  ",
			initial_mode = "insert",

			mappings = {
				n = {
					q = action.close,
					x = action.select_horizontal,
					v = action.select_vertical,
				},
			},
		},
	}
	telescope.setup(opts)

	local ext = {
		"fzf",
		"undo",
		"harpoon",
		"projects",
		"git_worktree",
		-- "persisted",
	}

	-- load extensions
	for _, extension in ipairs(ext) do
		telescope.load_extension(extension)
	end
end

return M

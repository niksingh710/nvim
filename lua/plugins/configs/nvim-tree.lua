local M = {}
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

M.config = function()
	local api = require("nvim-tree.api")

	local function attach(bufnr)
		-- This will make sure that newly created file get's open to edit
		api.events.subscribe(api.events.Event.FileCreated, function(file)
			vim.cmd("edit " .. file.fname)
		end)

		-- functions used to map
		local function opts(desc)
			return {
				desc = "nvim-tree: " .. desc,
				buffer = bufnr,
				noremap = true,
				silent = true,
				nowait = true,
			}
		end

		local function set(mode, data)
			for key, value in pairs(data) do
				vim.keymap.set(mode, key, value[1], value[2])
			end
		end

		local normal = {
			h = { api.node.navigate.parent_close, opts("Close Directory") },
			l = { api.node.open.edit, opts("Open") },
			H = { api.tree.collapse_all, opts("Close Directory") },
			L = { api.tree.expand_all, opts("Expand All") },
			v = { api.node.open.vertical, opts("Open: Vertical Split") },
			s = { api.node.open.horizontal, opts("Open: Horizontal Split") },
			C = { api.tree.change_root_to_node, opts("CD") },
			Z = { api.node.run.system, opts("Run System") },
			y = { api.fs.copy.node, opts("Copy") },
			c = { api.fs.copy.filename, opts("Copy Name") },
			["?"] = { api.tree.toggle_help, opts("Help") },
		}

		api.config.mappings.default_on_attach(bufnr)
		set("n", normal)

		vim.keymap.set("n", "P", function() -- Special fn to print node PATH
			local node = api.tree.get_node_under_cursor()
			print(node.absolute_path)
		end, opts("Print Node Path"))
	end

	local options = {
		on_attach = attach,
		disable_netrw = true,
		hijack_netrw = true,
		hijack_cursor = true,
		hijack_unnamed_buffer_when_opening = false,
		sync_root_with_cwd = true,
		update_focused_file = {
			enable = true,
			update_root = true,
		},
		view = {
			adaptive_size = false,
			side = "left",
			width = 30,
			preserve_window_proportions = true,
		},
		git = {
			enable = true,
			ignore = false,
		},
		filesystem_watchers = {
			enable = true,
		},
		actions = {
			open_file = {
				resize_window = true,
			},
		},
		diagnostics = {
			enable = true,
			show_on_dirs = true,
			show_on_open_dirs = false,
			debounce_delay = 50,
			severity = {
				min = vim.diagnostic.severity.WARNING,
				max = vim.diagnostic.severity.ERROR,
			},
			icons = {
				hint = icons.diagnostics.BoldHint or "",
				info = icons.diagnostics.BoldInformation or "",
				warning = icons.diagnostics.BoldWarning or "",
				error = icons.diagnostics.BoldError or "",
			},
		},
		renderer = {
			root_folder_label = ":t",
			highlight_git = true,
			highlight_opened_files = "none",

			indent_markers = {
				enable = true,
				inline_arrows = true,
				icons = {
					corner = "└",
					edge = "│",
					item = "│",
					none = " ",
				},
			},

			icons = {
				git_placement = "after",
				show = {
					file = true,
					folder = true,
					folder_arrow = true,
					git = true,
				},

				glyphs = {
					git = {
						unstaged = icons.git.FileUnstaged,
						staged = icons.git.FileStaged,
						unmerged = icons.git.FileUnmerged,
						renamed = icons.git.FileRenamed,
						untracked = icons.git.FileUntracked,
						deleted = icons.git.FileDeleted,
						ignored = icons.git.FileIgnored,
					},
				},
			},
		},
	}
	require("nvim-tree").setup(options)
end

return M

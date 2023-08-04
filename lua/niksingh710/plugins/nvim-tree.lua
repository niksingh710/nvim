local nvstatus, nvtree = pcall(require, "nvim-tree")
if not nvstatus then
	return
end

utils.map("n", {
	["<leader>e"] = { "<cmd>NvimTreeToggle<cr>", "File Explorer" },
})

-- nvim-tree requires it so that it does not show up at blank nvim screen `nvim .`
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local apistatus, api = pcall(require, "nvim-tree.api")
if not apistatus then
	return
end

local function mapping(bufnr)
	--
	-- functions used to map {{{
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

	-- }}}

	local normal = {
		["h"] = { api.node.navigate.parent_close, opts("Close Directory") },
		["l"] = { api.node.open.edit, opts("Open") },
		["H"] = { api.tree.collapse_all, opts("Close Directory") },
		["L"] = { api.tree.expand_all, opts("Expand All") },
		["v"] = { api.node.open.vertical, opts("Open: Vertical Split") },
		["s"] = { api.node.open.horizontal, opts("Open: Horizontal Split") },
		["?"] = { api.tree.toggle_help, opts("Help") },
		["C"] = { api.tree.change_root_to_node, opts("CD") },
		["Z"] = { api.node.run.system, opts("Run System") },
	}
	api.config.mappings.default_on_attach(bufnr)
	set("n", normal)

	vim.keymap.set("n", "P", function()
		local node = api.tree.get_node_under_cursor()
		print(node.absolute_path)
	end, opts("Print Node Path"))
end

nvtree.setup({
	on_attach = mapping,

	auto_reload_on_write = false,
	disable_netrw = true,
	hijack_cursor = true,
	hijack_netrw = true,
	hijack_unnamed_buffer_when_opening = false,

	respect_buf_cwd = false,
	root_dirs = {},
	prefer_startup_root = true,
	reload_on_bufenter = false,
	view = {
		adaptive_size = false,
		centralize_selection = true,
		width = 30,
		hide_root_folder = false,
		side = "left",
		preserve_window_proportions = true,
		number = false,
		relativenumber = false,
		signcolumn = "yes",
		float = {
			enable = false,
			quit_on_focus_loss = true,
			open_win_config = {
				relative = "editor",
				border = "rounded",
				width = 30,
				height = 30,
				row = 1,
				col = 1,
			},
		},
	},

	sort = {
		sorter = "name",
		folders_first = true,
	},
	renderer = {
		icons = {
			git_placement = "after",
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

		highlight_git = false,
		root_folder_label = ":t",
	},
	diagnostics = {
		enable = true,
		show_on_dirs = false,
		show_on_open_dirs = true,
		debounce_delay = 50,
		severity = {
			min = vim.diagnostic.severity.HINT,
			max = vim.diagnostic.severity.ERROR,
		},
		icons = {
			hint = " " .. icons.diagnostics.BoldHint,
			info = " " .. icons.diagnostics.BoldInformation,
			warning = " " .. icons.diagnostics.BoldWarning,
			error = " " .. icons.diagnostics.BoldError,
		},
	},
	system_open = {
		cmd = "xdg-open",
		args = {},
	},
	filters = {
		custom = { "node_modules", "\\.cache" },
	},
	trash = {
		cmd = "trash",
		require_confirm = true,
	},
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
	sync_root_with_cwd = true,
	update_focused_file = {
		enable = false,
		update_root = false,
	},
})

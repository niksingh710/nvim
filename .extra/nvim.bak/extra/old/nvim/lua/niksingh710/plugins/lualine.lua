local lstatus, lualine = pcall(require, "lualine")
if not lstatus then
	return
end

local colors = {
	darkgray = "#16161d",
	gray = "#727169",
	innerbg = nil,
	-- outerbg = "#16161D",
	outerbg = nil,
	normal = "#7e9cd8",
	insert = "#98bb6c",
	visual = "#ffa066",
	replace = "#e46876",
	command = "#e6c384",
}
local theme = {
	inactive = {
		a = { fg = colors.gray, bg = colors.outerbg, gui = "bold" },
		b = { fg = colors.gray, bg = colors.outerbg },
		c = { fg = colors.gray, bg = colors.innerbg },
	},
	visual = {
		a = { fg = colors.darkgray, bg = colors.visual, gui = "bold" },
		b = { fg = colors.gray, bg = colors.outerbg },
		c = { fg = colors.gray, bg = colors.innerbg },
	},
	replace = {
		a = { fg = colors.darkgray, bg = colors.replace, gui = "bold" },
		b = { fg = colors.gray, bg = colors.outerbg },
		c = { fg = colors.gray, bg = colors.innerbg },
	},
	normal = {
		a = { fg = colors.darkgray, bg = colors.normal, gui = "bold" },
		b = { fg = colors.gray, bg = colors.outerbg },
		c = { fg = colors.gray, bg = colors.innerbg },
	},
	insert = {
		a = { fg = colors.darkgray, bg = colors.insert, gui = "bold" },
		b = { fg = colors.gray, bg = colors.outerbg },
		c = { fg = colors.gray, bg = colors.innerbg },
	},
	command = {
		a = { fg = colors.darkgray, bg = colors.command, gui = "bold" },
		b = { fg = colors.gray, bg = colors.outerbg },
		c = { fg = colors.gray, bg = colors.innerbg },
	},
}

local statusline_hl = vim.api.nvim_get_hl_by_name("StatusLine", true)
local cursorline_hl = vim.api.nvim_get_hl_by_name("CursorLine", true)
local normal_hl = vim.api.nvim_get_hl_by_name("Normal", true)
vim.api.nvim_set_hl(0, "SLCopilot", { fg = "#6CC644", bg = statusline_hl.background })
vim.api.nvim_set_hl(0, "SLGitIcon", { fg = "#E8AB53", bg = cursorline_hl.background })
vim.api.nvim_set_hl(0, "SLBranchName", { fg = normal_hl.foreground, bg = cursorline_hl.background })
vim.api.nvim_set_hl(0, "SLSeparator", { fg = cursorline_hl.background, bg = statusline_hl.background })

-- Utility {{{
--
-- GIT {{{
-- -- try git status

-- helper function to loop over string lines
-- copied from https://stackoverflow.com/a/19329565
local function iterlines(s)
	if s:sub(-1) ~= "\n" then
		s = s .. "\n"
	end
	return s:gmatch("(.-)\n")
end

-- find directory
function find_dir(d)
	-- return if root
	if d == "/" then
		return d
	end
	-- initialize git_state variable
	if vim.b.git_state == nil then
		vim.b.git_state = { "", "", "", "" }
	end
	-- fix terminal
	if d:find("term://") ~= nil then
		return "/tmp"
	end
	-- fix fzf
	if d:find("/tmp/.*FZF") ~= nil then
		return "/tmp"
	end
	-- fix fugitive etc.
	if d:find("^%w+://") ~= nil then
		vim.b.git_state[1] = " " .. d:gsub("^(%w+)://.*", "%1") .. " "
		d = d:gsub("^%w+://", "")
	end
	-- check renaming
	local ok, _, code = os.rename(d, d)
	if not ok then
		if code ~= 2 then
			-- all other than not existing
			return d
		end
		-- not existing
		local newd = d:gsub("(.*/)[%w._-]+/?$", "%1")
		return find_dir(newd)
	end
	-- d ok
	return d
end

-- get git status
local function git_status()
	vim.b.git_state = { "", "", "" }
	-- get & check file directory
	file_dir = find_dir(vim.fn.expand("%:p:h"))
	-- check fugitive etc.
	if vim.b.git_state[1] ~= "" then
		return "u"
	end
	-- capture git status call
	local cmd = "git -C " .. file_dir .. " status --porcelain -b 2> /dev/null"
	local handle = assert(io.popen(cmd, "r"), "")
	-- output contains empty line at end (removed by iterlines)
	local output = assert(handle:read("*a"))
	-- close io
	handle:close()

	local git_state = { "", "", "", "" }
	-- branch coloring: 'o': up to date with origin; 'd': head detached; 'm': not up to date with origin
	local branch_col = "o"

	-- check if git repo
	if output == "" then
		-- not a git repo
		-- save to variable
		vim.b.git_state = git_state
		-- exit
		return branch_col
	end

	-- get line iterator
	local line_iter = iterlines(output)

	-- process first line (HEAD)
	local line = line_iter()
	if line:find("%(no branch%)") ~= nil then
		-- detached head
		branch_col = "d"
	else
		-- on branch
		local ahead = line:gsub(".*ahead (%d+).*", "%1")
		local behind = line:gsub(".*behind (%d+).*", "%1")
		-- convert non-numeric to nil
		ahead = tonumber(ahead)
		behind = tonumber(behind)
		if behind ~= nil then
			git_state[1] = "↓ " .. tostring(behind) .. " "
		end
		if ahead ~= nil then
			git_state[1] = git_state[1] .. "↑ " .. tostring(ahead) .. " "
		end
	end

	-- loop over residual lines (files) &
	-- store number of files
	local git_num = { 0, 0, 0 }
	---@diagnostic disable-next-line: redefined-local
	for line in line_iter do
		branch_col = "m"
		-- get first char
		local first = line:gsub("^(.).*", "%1")
		if first == "?" then
			-- untracked
			git_num[3] = git_num[3] + 1
		elseif first ~= " " then
			-- staged
			git_num[1] = git_num[1] + 1
		end
		-- get second char
		local second = line:gsub("^.(.).*", "%1")
		if second == "M" then
			-- modified
			git_num[2] = git_num[2] + 1
		end
	end

	-- build output string
	if git_num[1] ~= 0 then
		git_state[2] = "● " .. git_num[1]
	end
	if git_num[2] ~= 0 then
		git_state[3] = "+ " .. git_num[2]
	end
	if git_num[3] ~= 0 then
		git_state[4] = "… " .. git_num[3]
	end

	-- save to variable
	vim.b.git_state = git_state

	return branch_col
end -- }}}
local function diff_source()
	---@diagnostic disable-next-line: undefined-field
	local gitsigns = vim.b.gitsigns_status_dict
	if gitsigns then
		return {
			added = gitsigns.added,
			modified = gitsigns.changed,
			removed = gitsigns.removed,
		}
	end
end

local window_width_limit = 100
local utils = {
	env_cleanup = function(venv)
		if string.find(venv, "/") then
			local final_venv = venv
			for w in venv:gmatch("([^/]+)") do
				final_venv = w
			end
			venv = final_venv
		end
		return venv
	end,
}

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.o.columns > window_width_limit
	end,
}

-- }}}

local components = {
	mode = {
		"mode",
		fmt = function()
			return icons.misc.LualineFmt
		end,
	},
	branch = {
		"b:gitsigns_head",
		icon = icons.git.branch,
		color = { gui = "bold" },
	},
	diff = {
		"diff",
		source = diff_source,
		symbols = {
			added = icons.git.LineAdded .. " ",
			modified = icons.git.LineModified .. " ",
			removed = icons.git.LineRemoved .. " ",
		},
		padding = { left = 2, right = 1 },
		diff_color = {
			added = { fg = colors.green },
			modified = { fg = colors.yellow },
			removed = { fg = colors.red },
		},
		cond = nil,
	},
	python_env = {
		function()
			if vim.bo.filetype == "python" then
				local venv = os.getenv("CONDA_DEFAULT_ENV") or os.getenv("VIRTUAL_ENV")
				if venv then
					local icons = require("nvim-web-devicons")
					local py_icon, _ = icons.get_icon(".py")
					return string.format(" " .. py_icon .. " (%s)", utils.env_cleanup(venv))
				end
			end
			return ""
		end,
		color = { fg = colors.green },
		-- cond = conditions.hide_in_width,
	},
	diagnostics = {
		"diagnostics",
		sources = { "nvim_diagnostic" },
		symbols = {
			error = icons.diagnostics.BoldError .. " ",
			warn = icons.diagnostics.BoldWarning .. " ",
			info = icons.diagnostics.BoldInformation .. " ",
			hint = icons.diagnostics.BoldHint .. " ",
		},
		-- cond = conditions.hide_in_width,
	},
	treesitter = {
		function()
			return icons.ui.Tree
		end,
		color = function()
			local buf = vim.api.nvim_get_current_buf()
			local ts = vim.treesitter.highlighter.active[buf]
			return { fg = ts and not vim.tbl_isempty(ts) and colors.green or colors.red }
		end,
		cond = conditions.hide_in_width,
	},
	lsp = {
		function()
			local lsp_clients = vim.lsp.get_active_clients()
			local lsp_names = {}
			local copilot_active = false

			if next(lsp_clients) == nil then
				return "LS Inactive"
			end
			for _, client in ipairs(lsp_clients) do
				if client.name ~= "null-ls" and client.name ~= "copilot" then
					table.insert(lsp_names, client.name)
				end
				if client.name == "copilot" then
					copilot_active = true
				end
			end
			local status = lsp_names
			local nstatus, null_ls = pcall(require, "null-ls")
			if not nstatus then
				return vim.fn.uniq(status)
			end

			-- Null-ls {{{
			local buf_ft = vim.bo.filetype

			function registered_method(filetype)
				local sources = require("null-ls.sources")
				local available_sources = sources.get_available(filetype)
				local registered = {}
				for _, source in ipairs(available_sources) do
					for method in pairs(source.methods) do
						registered[method] = registered[method] or {}
						table.insert(registered[method], source.name)
					end
				end
				return registered or {}
			end

			local f = null_ls.methods.FORMATTING
			vim.list_extend(status, registered_method(buf_ft)[f])

			-- local d = null_ls.methods.DIAGNOSTICS
			local alternative_methods = {
				null_ls.methods.DIAGNOSTICS,
				null_ls.methods.DIAGNOSTICS_ON_OPEN,
				null_ls.methods.DIAGNOSTICS_ON_SAVE,
			}

			local registered_providers = registered_method(buf_ft)
			local providers_for_methods = vim.tbl_flatten(vim.tbl_map(function(m)
				return registered_providers[m] or {}
			end, alternative_methods))

			vim.list_extend(status, providers_for_methods)

			local unique_client_names = vim.fn.uniq(status)
			local data = "[" .. table.concat(unique_client_names, ", ") .. "]"

			if copilot_active then
				data = data .. "%#SLCopilot#" .. " " .. icons.git.Octoface .. "%*"
			end

			return data
			-- }}}
		end,
		color = { gui = "bold" },
		cond = conditions.hide_in_width,
	},

	location = { "location" },
	progress = {
		"progress",
		fmt = function()
			return "%P/%L"
		end,
		color = {},
	},
	spaces = {
		function()
			local shiftwidth = vim.api.nvim_buf_get_option(0, "shiftwidth")
			return icons.ui.Tab .. " " .. shiftwidth
		end,
		padding = 1,
	},
	encoding = {
		"o:encoding",
		fmt = string.upper,
		color = {},
		cond = conditions.hide_in_width,
	},
	filetype = { "filetype", cond = nil, padding = { left = 1, right = 1 } },
	scrollbar = {
		function()
			local current_line = vim.fn.line(".")
			local total_lines = vim.fn.line("$")
			local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
			local line_ratio = current_line / total_lines
			local index = math.ceil(line_ratio * #chars)
			return chars[index]
		end,
		padding = { left = 0, right = 0 },
		color = "SLProgress",
		cond = nil,
	},
}

local line_b = {
	{
		"branch",
		color = function(_)
			local gs = git_status()
			if gs == "d" then
				return { fg = "#916BDD" }
			elseif gs ~= "m" then
				return { fg = "#769945" }
			end
		end,
	},
	{
		-- head status
		"vim.b.git_state[1]",
		color = function(_)
			if vim.b.git_state[1]:find("^ %w+ $") ~= nil then
				return { fg = "#F49B55" }
			end
		end,
		padding = { left = 0, right = 0 },
	},
	{
		-- staged files
		"vim.b.git_state[2]",
		color = { fg = "#769945" },
		padding = { left = 0, right = 1 },
	},
	{
		-- modified files
		"vim.b.git_state[3]",
		color = { fg = "#D75F00" },
		padding = { left = 0, right = 1 },
	},
	{
		-- untracked files
		"vim.b.git_state[4]",
		color = { fg = "#D99809" },
		padding = { left = 0, right = 1 },
	},
}

lualine.setup({
	options = {
		icons_enabled = true,
		-- theme = "auto",
		theme = theme,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = {
			components.mode,
		},
		-- lualine_b = {
		-- 	components.branch,
		-- },
		lualine_b = line_b,
		lualine_c = {
			components.diff,
			components.python_env,
		},
		lualine_x = {
			{
				require("noice").api.statusline.mode.get,
				cond = require("noice").api.statusline.mode.has,
				color = { fg = "#ff9e64" },
			},
			components.diagnostics,
			components.lsp,
			components.spaces,
			components.filetype,
		},
		lualine_y = { components.location },
		lualine_z = {
			components.progress,
		},
	},
	tabline = {},
	extensions = {},
})

-- {
--   bg0 = "#11121d",
--   bg1 = "#1a1b2a",
--   bg2 = "#212234",
--   bg3 = "#353945",
--   bg4 = "#4a5057",
--   bg5 = "#282c34",
--   bg_blue = "#9fbbf3",
--   bg_green = "#98c379",
--   bg_red = "#fe6d85",
--   black = "#06080a",
--   blue = "#7199ee",
--   cyan = "#38a89d",
--   diff_add = "#1e2326",
--   diff_blue = "#2a3a5a",
--   diff_change = "#262b3d",
--   diff_delete = "#281b27",
--   diff_green = "#587738",
--   diff_red = "#773440",
--   diff_text = "#1c4474",
--   fg = "#a0a8cd",
--   green = "#95c561",
--   grey = "#4a5057",
--   none = "NONE",
--   orange = "#f6955b",
--   purple = "#a485dd",
--   red = "#ee6d85",
--   yellow = "#d7a65f"
-- }
Press E

local statusline_hl = vim.api.nvim_get_hl_by_name("StatusLine", true)
local cursorline_hl = vim.api.nvim_get_hl_by_name("CursorLine", true)
vim.api.nvim_set_hl(0, "SLGreen", { fg = "#6CC644", bg = statusline_hl.background })
vim.api.nvim_set_hl(0, "SLGitIcon", { fg = "#E8AB53", bg = cursorline_hl.background })

local theme = function()
	local colors = {
		darkgray = "#16161d",
		gray = "#727169",
		innerbg = nil,
		outerbg = "#16161D",
		normal = "#7e9cd8",
		insert = "#98bb6c",
		visual = "#ffa066",
		replace = "#e46876",
		command = "#e6c384",
	}
	return {
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
end

local lok, lualine = pcall(require, "lualine")
if not lok then
	vim.notify("Lua line failed to load!!")
	return
end

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

local require_noice_fix = function()
	local nok, noice = pcall(require, "noice")
	if not nok then
		return {}
	end
	return {
		noice.api.statusline.mode.get,
		cond = noice.api.statusline.mode.has,
		color = { fg = "#ff9e64" },
	}
end

local components = {
	require_noice_fix = require_noice_fix(),

	mode = {
		"mode",
		fmt = function()
			return icons.misc.LualineFmt
		end,
	},
	branch = {
		"b:gitsigns_head",
		icon = icons.git.Branch,
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
	},
	filetype = { "filetype", cond = nil, padding = { left = 1, right = 1 } },
	fileformat = { "fileformat", cond = nil, padding = { left = 1, right = 1 }, color = "SLGreen" },

	lsp = {
		function()
			-- lsp name {{{
			local lsp_clients = vim.lsp.get_active_clients()
			local lsp_names = {}

			if next(lsp_clients) == nil then
				return "Ls Inactive"
			end

			for _, client in ipairs(lsp_clients) do
				if client.name ~= "copilot" and client.name ~= "null-ls" then
					table.insert(lsp_names, client.name)
				end
			end
			-- }}}

			local status = lsp_names

			-- null-ls attached listing{{{
			local nok, null_ls = pcall(require, "null-ls")
			if nok then
				local buf_ft = vim.bo.filetype
				local function registered_method(filetype)
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
			end

			local unique_client_names = vim.fn.uniq(status) -- }}}

			local data = "[" .. table.concat(unique_client_names, ", ") .. "]"
			return data
		end,
	},
	copilot = function()
		local lsp_clients = vim.lsp.get_active_clients()
		local copilot_active = false
    local str = ""
		if next(lsp_clients) == nil then
			return str
		end

		for _, client in ipairs(lsp_clients) do
			if client.name == "copilot" then
				copilot_active = true
				break
			end
		end
		if copilot_active then
			str = "%#SLGreen#" .. icons.git.Octoface .. "%*"
		end
		return str
	end,
}

local sections = {
	lualine_a = { "mode" },
	lualine_b = { components.fileformat, "encoding", components.require_noice_fix },
	lualine_c = { components.branch, components.diff },
	lualine_x = { components.diagnostics, components.filetype, components.lsp },
	lualine_y = { "progress" },
	lualine_z = { "location", components.copilot },
}

local opts = {
	options = {
		icons_enabled = true,
		-- theme = "auto",
		theme = theme(),
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
		always_divide_middle = true,
	},
	sections = sections,
}

lualine.setup(opts)

local M = {}

M.noice_config = function()
	local options = {
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
			progress = {
				enabled = false,
			},
			hover = {
				enabled = false,
			},
			signature = {
				enabled = false,
			},
		},
		cmdline = {
			format = {
				help = { pattern = "^:%s*tab he?l?p?%s+", icon = "" },
			},
		},
		popupmenu = {
			enabled = true, -- enables the Noice popupmenu UI
			---@type 'nui'|'cmp'
			backend = "cmp", -- backend to use to show regular cmdline completions
			---@type NoicePopupmenuItemKind|false
			-- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
			kind_icons = {}, -- set to `false` to disable icons
		},
		presets = {
			bottom_search = false, -- use a classic bottom cmdline for search
			long_message_to_split = true, -- long messages will be sent to a split
			inc_rename = false, -- enables an input dialog for inc-rename.nvim
			lsp_doc_border = false, -- add a border to hover docs and signature help
			command_palette = {
				views = {
					cmdline_popup = {
						position = {
							row = 10,
							col = "50%",
						},
						size = {
							min_width = 60,
							width = "auto",
							height = "auto",
						},
					},
				},
			},
		},
	}
	local noice = require("noice")
	noice.setup(options)
	local lok, lualine = pcall(require, "lualine")
	if lok then
		local indicator = {
			require("noice").api.statusline.mode.get,
			cond = require("noice").api.statusline.mode.has,
			color = { fg = "#ff9e64" },
		}

		local b = lualine.get_config().sections.lualine_b
		table.insert(b, indicator)
		lualine.setup({
			sections = {
				lualine_b = b,
			},
		})
	end
end

M.notify_options = {
	split = true,
	background_colour = "#000000",
	render = "compact",
	stages = "fade_in_slide_out",
	top_down = true,
}

M.gitsigns = {
	current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
	signs = {
		add = {
			hl = "GitSignsAdd",
			text = icons.ui.BoldLineLeft,
			numhl = "GitSignsAddNr",
			linehl = "GitSignsAddLn",
		},
		change = {
			hl = "GitSignsChange",
			text = icons.ui.BoldLineLeft,
			numhl = "GitSignsChangeNr",
			linehl = "GitSignsChangeLn",
		},
		delete = {
			hl = "GitSignsDelete",
			text = icons.ui.Triangle,
			numhl = "GitSignsDeleteNr",
			linehl = "GitSignsDeleteLn",
		},
		topdelete = {
			hl = "GitSignsDelete",
			text = icons.ui.Triangle,
			numhl = "GitSignsDeleteNr",
			linehl = "GitSignsDeleteLn",
		},
		changedelete = {
			hl = "GitSignsChange",
			text = icons.ui.BoldLineLeft,
			numhl = "GitSignsChangeNr",
			linehl = "GitSignsChangeLn",
		},
	},
}

M.ufo = function()
	require("ufo").setup({
		open_fold_hl_timeout = 0,
		preview = {
			win_config = {
				border = border or "rounded",
				winblend = 0,
			},
		},
		provider_selector = function()
			return { "lsp", "indent" }
		end,
	})
end

M.auto_save = function()
	require("auto-save").setup({
		execution_message = {
			enabled = false,
			message = function() -- message to print on save
				return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
			end,
			dim = 0.18, -- dim the color of `message`
			cleaning_interval = 1250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
		},
	})
end

M.gitsigns_init = function()
	-- load gitsigns only when a git file is opened
	-- TODO: Fix this for softly linked directories.
	vim.api.nvim_create_autocmd({ "BufRead" }, {
		group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
		callback = function()
			vim.fn.system("git -C " .. '"' .. vim.fn.expand("%:p:h") .. '"' .. " rev-parse")
			if vim.v.shell_error == 0 then
				vim.api.nvim_del_augroup_by_name("GitSignsLazyLoad")
				vim.schedule(function()
					require("lazy").load({ plugins = { "gitsigns.nvim" } })
				end)
			end
		end,
	})
end

M.rest_opts = {
	-- Open request results in a horizontal split
	result_split_horizontal = false,
	-- Keep the http file buffer above|left when split horizontal|vertical
	result_split_in_place = false,
	-- Skip SSL verification, useful for unknown certificates
	skip_ssl_verification = true,
	-- Encode URL before making request
	encode_url = true,
	-- Highlight request on run
	highlight = {
		enabled = true,
		timeout = 150,
	},
	result = {
		-- toggle showing URL, HTTP info, headers at top the of result window
		show_url = true,
		-- show the generated curl command in case you want to launch
		-- the same request via the terminal (can be verbose)
		show_curl_command = false,
		show_http_info = true,
		show_headers = true,
		-- executables or functions for formatting response body [optional]
		-- set them to false if you want to disable them
		formatters = {
			json = "jq",
			html = function(body)
				return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
			end,
		},
	},
	-- Jump to request line on run
	jump_to_request = false,
	env_file = ".env",
	custom_dynamic_variables = {},
	yank_dry_run = true,
}

M.image_opts = {
	backend = "ueberzug",
	max_width = 50,
	max_height = 50,
	integrations = {
		markdown = {
			only_render_image_at_cursor = true,
		},
	},
}

M.firenvim = function()
	vim.g.firenvim_config = {
		localSettings = {
			[".*"] = {
				takeover = "never",
				cmdline = "neovim",
			},
		},
	}
	vim.api.nvim_create_autocmd({ "BufEnter" }, {
		pattern = "leetcode.com_*.txt",
		callback = function()
			if utils.check.vimcmd("Copilot") then
				vim.cmd("Copilot disable")
			end
		end,
	})
end

return M

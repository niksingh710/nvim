-- Utility Functions {{{
function configure(filename)
	return function()
		require("niksingh710.plugins." .. filename)
	end
end

function telescope_extension(obj)
	if obj.setup then
		obj.setup()
	end
	return function()
		local telestatus, telescope = pcall(require, "telescope")
		if not telestatus then
			return
		end
		telescope.load_extension(obj.extension)
	end
end

-- }}}

return {

	-- Themes: curr = Tokyodark {{{
	"xiyaowong/transparent.nvim",
	"tiagovla/tokyodark.nvim",
	-- }}}

	-- Glancing plugins : which-key, telescope {{{
	{
		"folke/which-key.nvim",
		-- make sure to not use this to register keymappings as if which-key is not available mappings will go away.
		-- use this to just name mappings (utils.map) should handle this
		opts = {
			window = {
				-- border = "rounded",
				border = "single",
				position = "bottom",
				margin = { 0, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]
				padding = { 1, 1, 1, 1 }, -- extra window padding [top, right, bottom, left]
				winblend = 0,
			},
			layout = {
				height = { min = 1, max = 25 }, -- min and max height of the columns
				width = { min = 10, max = 50 }, -- min and max width of the columns
				spacing = 3, -- spacing between columns
				align = "center", -- align columns left, center or right
			},
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.2",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = configure("telescope"),
	},

	-- Extensions: Telescope {{{
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			tag = "0.1.2",
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
		},
		build = "make",
		config = telescope_extension({ extension = "fzf" }),
	},
	{
		"nvim-telescope/telescope-media-files.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			tag = "0.1.2",
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
		},
		config = telescope_extension({ extension = "media_files" }),
	},

	{
		"ahmedkhalf/project.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			tag = "0.1.2",
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
		},
		config = telescope_extension({
			extension = "projects",
			setup = function()
				utils.map("n", {
					["<leader>sp"] = { "<cmd>Telescope projects<cr>", "Search Projects" },
				})
			end,
		}),
	},
	{
		"ElPiloto/telescope-vimwiki.nvim",
		dependencies = {
			"vimwiki/vimwiki",
			{
				"nvim-telescope/telescope.nvim",
				tag = "0.1.2",
				dependencies = {
					"nvim-lua/plenary.nvim",
				},
			},
		},
		config = telescope_extension({
			extension = "vimwiki",
			setup = function()
				utils.map("n", {
					["<ledaer>sww"] = { "<cmd>Telescope vimwiki<cr>", "Search vimwiki files" },
					["<leader>swg"] = { "<cmd>Telescope vimwiki live_grep<cr>", "Grep vimwiki files" },
				})
				local ws, _ = pcall(require, "which-key")
				if ws then
					utils.map("n", {
						["<ledaer>"] = {
							["s"] = {
								["w"] = {
									name = "vimwikki",
								},
							},
						},
					}, true)
				end
			end,
		}),
	},
	{
		"debugloop/telescope-undo.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			tag = "0.1.2",
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
		},
		config = telescope_extension({
			extension = "undo",
			setup = function()
				utils.map("n", { ["<leader>su"] = { "<cmd>Telescope undo<cr>", "Undo" } })
			end,
		}),
	},
	-- }}}

	--  }}}

	-- File explorer: nvim, oil {{{
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = configure("nvim-tree"),
	},
	{
		"stevearc/oil.nvim",
		opts = {
			keymaps = {
				["g?"] = "actions.show_help",
				["<c-s>"] = "actions.select_vsplit",
				["<c-h>"] = "actions.select_split",
				["<c-t>"] = "actions.select_tab",
				["<c-p>"] = "actions.preview",
				["<c-c>"] = "actions.close",
				["<c-l>"] = "actions.refresh",
				["<s-h>"] = "actions.parent",
				["<s-l>"] = "actions.select",
				["<cr>"] = "actions.select",
				["s-<cr>"] = "actions.open_cwd",
				["`"] = "actions.cd",
				["~"] = "actions.tcd",
				["g."] = "actions.toggle_hidden",
			},
		},
	},
	-- }}}

	-- Experience Like: todo highlight {{{
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup()
			local telestatus, _ = pcall(require, "telescope")
			if not telestatus then
				return
			end
			utils.map("n", { ["<leader>st"] = { "<cmd>TodoTelescope<cr>", "Comment" } })
		end,
	},
	{
		"axieax/urlview.nvim",
		config = function()
			require("urlview").setup({
				default_title = "Links:",
				-- Default picker to display links with
				-- Options: "native" (vim.ui.select) or "telescope"
				default_picker = "native",
				-- Set the default protocol for us to prefix URLs with if they don't start with http/https
				default_prefix = "https://",
				default_action = "system",
			})
			utils.map("n", {
				["<leader>Uo"] = { "<Cmd>UrlView buffer<CR>", "Browser!!" },
				["<leader>Uc"] = { "<Cmd>UrlView buffer action=clipboard<CR>", "Clipboard!!" },
			})
			local ws, _ = pcall(require, "which-key")
			if ws then
				utils.map("n", {
					["<leader>"] = {
						["U"] = {
							name = "Url Handler",
						},
					},
				}, true)
			end
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter",
			},
		},
		opts = {
			space_char_blankline = " ",
			show_current_context = true,
			show_current_context_start = true,
		},
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"windwp/nvim-ts-autotag",
		opts = {},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"m-demare/hlargs.nvim",
		opts = {},
	},
	{
		"anuvyklack/pretty-fold.nvim",
		opts = {},
	},
	-- }}}

	-- ide type: treesitter lsp formatter and all {{{
	--
	{
		"goolord/alpha-nvim",
		config = configure("alpha"),
	},

	{
		"olimorris/persisted.nvim",
		config = function()
			local rtimedir = os.getenv("XDG_RUNTIME_DIR")
			require("persisted").setup({
				should_autosave = function()
					-- do not autosave if the alpha dashboard is the current filetype
					if vim.bo.filetype == "alpha" or vim.bo.filetype == "" then
						return false
					end
					return true
				end,
				ignored_dirs = {
					rtimedir .. "/firenvim",
				},
			})
			utils.map("n", {
				["<leader>Sd"] = { ":SessionLoad", "Restore last session for current dir" },
				["<leader>S."] = { ":SessionLoadLast", "Restore last Session" },
				["<leader>Sq"] = { ":SessionDelete<cr>:quit!<cr>", "Quit without saving session" },
			})
			utils.map("n", {
				["<leader>sP"] = { "<cmd>Telescope persisted<cr>", "Search Seasson" },
				["<leader>Sl"] = { ":Telescope persisted<cr>", "Telescope for persisted Session" },
			})
			local ws, _ = pcall(require, "which-key")
			if ws then
				utils.map("n", {
					["<leader>"] = {
						["S"] = { name = "Session" },
					},
				}, true)
			end
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		opts = {
			ensure_installed = {
				"markdown",
				"markdown_inline",
				"astro",
				"css",
				"glimmer",
				"graphql",
				"handlebars",
				"html",
				"javascript",
				"lua",
				"nix",
				"php",
				"python",
				"rescript",
				"scss",
				"svelte",
				"tsx",
				"twig",
				"typescript",
				"vim",
				"vue",
				"go",
			},
			context_commentstring = {
				enable = true,
			},
		},
		-- TODO: Give a thought on folding
		-- config = function()
		--  vim.cmd([[
		--          set foldmethod=expr
		--        set foldexpr=nvim_treesitter#foldexpr()
		--      set nofoldenable
		--  ]])
		-- end
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"williamboman/mason.nvim",
		},
		config = configure("lsp"),
	},
	{
		"nvimdev/lspsaga.nvim",
		event = "lspattach",
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter", -- optional
				opts = {
					ensure_installed = {
						"markdown",
						"markdown_inline",
					},
				},
			},

			"nvim-tree/nvim-web-devicons", -- optional
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {}, -- this is equalent to setup({}) function
	},
	{
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		dependencies = {
			"onsails/lspkind.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-buffer",
			"FelipeLema/cmp-async-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-calc",
			"saadparwaiz1/cmp_luasnip",
			"uga-rosa/cmp-dictionary",
			"David-Kunz/cmp-npm",
			"tamago324/cmp-zsh",
			{ "L3MON4D3/LuaSnip", dependencies = { "rafamadriz/friendly-snippets" } },
		},
		config = configure("cmp"),
	},
	{
		"rcarriga/nvim-dap-ui",
		config = configure("dap-ui"),
		dependencies = {
			{ "theHamsta/nvim-dap-virtual-text", config = true },
			"mfussenegger/nvim-dap",
			{
				"folke/neodev.nvim",
				opts = {
					library = { plugins = { "nvim-dap-ui" }, types = true },
				},
			},
		},
		lazy = false,
	},
	{
		"leoluz/nvim-dap-go",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		ft = "go",
		opts = function()
			require("dap-go").setup()
			utils.map("n", {
				["<leader>dgt"] = {
					function()
						require("dap-go").debug_test()
					end,
					"Debug go test",
				},
				["<leader>dgl"] = {
					function()
						require("dap-go").debug_last()
					end,
					"Debug last go test",
				},
			})
		end,
	},
	{
		"olexsmir/gopher.nvim",
		dependencies = { -- dependencies
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = configure("null-ls"),
	},
	-- Null-ls backup
	-- {
	--   "mfussenegger/nvim-lint",
	--   config = configure("nvim-lint")
	-- },
	-- {
	--   "mhartington/formatter.nvim",
	--   config = configure("formatter")
	-- },
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
			utils.map("x", { ["<leader>/"] = { "<plug>(comment_toggle_linewise_visual)", "Comment" } })
			utils.map("n", { ["<leader>/"] = { "<plug>(comment_toggle_linewise_current)", "Comment" } })
		end,
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = configure("bufferline"),
	},
	{
		"nvim-lualine/lualine.nvim",
		config = configure("lualine"),
	},
	{
		"glacambre/firenvim",

		-- Lazy load firenvim
		-- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
		cond = not not vim.g.started_by_firenvim,
		build = function()
			require("lazy").load({ plugins = "firenvim", wait = true })
			vim.fn["firenvim#install"](0)
		end,
		config = configure("firenvim"),
		lazy = false,
	},
	{
		"sudormrfbin/cheatsheet.nvim",
		config = function()
			utils.map("n", { ["<leader>s?"] = { "<cmd>Cheatsheet<cr>", "Cheatsheet" } })
		end,
		dependencies = {
			{ "nvim-telescope/telescope.nvim" },
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
		},
	},
	-- }}}

	-- Extra: All above is for ide this is glory stuff -- Not required but recommended
	"imsnif/kdl.vim",
	"mg979/vim-visual-multi",
	"lewis6991/gitsigns.nvim",
	"vimwiki/vimwiki",
	{
		"stevearc/dressing.nvim",
		opts = {},
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = true,
	},

	{
		"tomiis4/Hypersonic.nvim",
		cmd = "Hypersonic",
		config = function()
			require("Hypersonic").setup()
			utils.map("v", {
				["<leader>r"] = { ":Hypersonic<cr>", "RegEx Info" },
			})
		end,
	},
	{
		"anuvyklack/windows.nvim",
		dependencies = {
			"anuvyklack/middleclass",
			"anuvyklack/animation.nvim",
		},
		config = function()
			vim.o.winwidth = 10
			vim.o.winminwidth = 10
			vim.o.equalalways = false
			require("windows").setup()
		end,
	},
	{
		"nvim-treesitter/playground",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			utils.map("n", {
				["<leader>op"] = { "<cmd>TSPlaygroundToggle<cr>", "Playground" },
			})
		end,
	},
	{
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup()
			utils.map("n", {
				["<leader>Zz"] = { "<cmd>ZenMode<cr>", "Zen Mode" },
			})
			local ws, _ = pcall(require, "which-key")
			if ws then
				utils.map("n", {
					["<ledaer>"] = {
						["Z"] = {
							name = "Zen",
						},
					},
				}, true)
			end
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"folke/twilight.nvim",
		config = function()
			require("zen-mode").setup()
			utils.map("n", {
				["<leader>Zt"] = { "<cmd>Twilight<cr>", "Twilight" },
			})
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},

	{
		"zbirenbaum/copilot-cmp",
		dependencies = {
			{
				"zbirenbaum/copilot.lua",
				config = function()
					require("copilot").setup({
						-- suggestion = { enabled = false },
						panel = { enabled = false },
						filetypes = {
							yaml = true,
							markdown = true,
							help = true,
							gitcommit = true,
							gitrebase = true,
							hgcommit = true,
							svn = true,
							cvs = true,
							["."] = true,
						},
						suggestion = {
							enabled = true,
							auto_trigger = true,
							debounce = 75,
							keymap = {
								accept = "<c-l>",
								next = "<c-]>",
								prev = "<c-[>",
								dismiss = "<C-e>",
							},
						},
					})
				end,
				-- cmd = "Copilot",
				-- event = "InsertEnter",
			},
		},
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	{
		"itchyny/calendar.vim",
		config = function()
			if utils.check.file_exists(os.getenv("HOME") .. "/.cache/calendar.vim/credentials.vim") then
				vim.cmd([[
        let g:calendar_google_calendar = 1
        let g:calendar_google_task = 1
        source ~/.cache/calendar.vim/credentials.vim
        ]])
				utils.map("n", { ["<leader>C"] = { ":Calendar<CR>", "Calender" } })
			end
		end,
	},
	{
		"ellisonleao/glow.nvim",
		config = function()
			require("glow").setup()
			utils.map("n", { ["<leader>mg"] = { "<cmd>Glow<cr>", "Glow" } })
			local ws, _ = pcall(require, "which-key")
			if ws then
				utils.map("n", {
					["<ledaer>"] = {
						["m"] = {
							name = "Markdown",
						},
					},
				}, true)
			end
		end,
	},
	{
		"ethanholz/nvim-lastplace",
		event = "BufRead",
		opts = {
			lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
			lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
			lastplace_open_folds = true,
		},
	},
	{
		"karb94/neoscroll.nvim",
		event = "WinScrolled",
		opts = {
			-- All these keys will be mapped to their corresponding default scrolling animation
			mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
			hide_cursor = true, -- Hide cursor while scrolling
			stop_eof = true, -- Stop at <EOF> when scrolling downwards
			use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
			respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
			cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
			easing_function = nil, -- Default easing function
			pre_hook = nil, -- Function to run before the scrolling animation starts
			post_hook = nil, -- Function to run after the scrolling animation ends
		},
	},
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		ft = "markdown",
		config = function()
			vim.g.mkdp_auto_start = 1
			utils.map("n", { ["<leader>mb"] = { "<cr>MarkdownPreview<cr>", "Glow" } })
		end,
	},
	{
		"j-hui/fidget.nvim",
		branch = "legacy",
		config = function()
			require("fidget").setup({
				text = {
					spinner = "moon",
				},
				window = {
					relative = "win", -- where to anchor, either "win" or "editor"
					blend = 20, -- &winblend for the window
					zindex = nil, -- the zindex value for the window
					border = "none", -- style of border for the fidget window
				},
			})
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({ "css", "scss", "html", "javascript" }, {
				rgb = true, -- #rgb hex codes
				rrggbb = true, -- #rrggbb hex codes
				rrggbbaa = true, -- #rrggbbaa hex codes
				rgb_fn = true, -- css rgb() and rgba() functions
				hsl_fn = true, -- css hsl() and hsla() functions
				css = true, -- enable all css features: rgb_fn, hsl_fn, names, rgb, rrggbb
				css_fn = true, -- enable all css *functions*: rgb_fn, hsl_fn
			})
		end,
	},
	{
		"nacro90/numb.nvim",
		event = "bufread",
		config = function()
			require("numb").setup({
				show_numbers = true, -- enable 'number' for the window while peeking
				show_cursorline = true, -- enable 'cursorline' for the window while peeking
			})
		end,
	},
	{
		"ziontee113/icon-picker.nvim",
		config = function()
			require("icon-picker").setup({})
			utils.map("i", {
				["<c-.>"] = "<cmd>IconPickerInsert<cr>",
			})
			utils.map("n", {
				["<leader>si"] = { "<cmd>IconPickerYank<cr>", "Icon Picker Yank" },
			})
		end,
	},
	{
		"folke/noice.nvim",
		opts = { -- {{{
			lsp = {
				-- override markdown rendering
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
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
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				-- command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = true, -- add a border to hover docs and signature help
				command_palette = {
					views = {
						cmdline_popup = {
							position = {
								row = 60,
								col = "50%",
							},
							size = {
								min_width = 60,
								width = "auto",
								height = "auto",
							},
						},
						popupmenu = {
							relative = "editor",
							position = {
								row = 40,
								col = "50%",
							},
							size = {
								width = 60,
								height = "auto",
								max_height = 15,
							},
							border = {
								style = "rounded",
								padding = { 0, 1 },
							},
							win_options = {
								winhighlight = { Normal = "Normal", FloatBorder = "NoiceCmdlinePopupBorder" },
							},
						},
					},
				},
			},
		}, -- }}}
		event = "VeryLazy",
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			-- `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			{
				"rcarriga/nvim-notify",
				opts = {
					background_colour = "#00000000",
					render = "compact",
				},
			},
		},
	},
}

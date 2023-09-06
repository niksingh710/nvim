-- Plugins that need to run globally make sure to make them `lazy=false` e.g gitsings,neoscroll,nvim-treesitter etc
return {
	{ -- themes
		"xiyaowong/transparent.nvim",
		"tiagovla/tokyodark.nvim", -- this needs to be there
	},

	{ -- language
		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			dependencies = {
				{ "windwp/nvim-ts-autotag", config = true },
				{ "JoosepAlviste/nvim-ts-context-commentstring" },
				"nvim-treesitter/nvim-treesitter-textobjects",
				{
					"lukas-reineke/indent-blankline.nvim",
					opts = {
						space_char_blankline = " ",
						show_current_context = true,
						show_current_context_start = true,
					},
				},
				"kiyoon/treesitter-indent-object.nvim",
			},
		},

		{
			"neovim/nvim-lspconfig",
			dependencies = {
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-cmdline",
				"hrsh7th/nvim-cmp",
				"L3MON4D3/LuaSnip",
				"saadparwaiz1/cmp_luasnip",
			},
		},

		{
			"mfussenegger/nvim-dap",
			dependencies = {
				"jay-babu/mason-nvim-dap.nvim",

				{ -- language specific
					{ "leoluz/nvim-dap-go", ft = "go" }, --go
				},
			},
		},

		-- Golang features
		{
			"olexsmir/gopher.nvim",
			ft = "go",
			config = true,
			build = function()
				vim.cmd("silent! GoInstallDeps")
			end,
		},

		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			opts = {}, -- this is equalent to setup({}) function
		},
		{
			"numToStr/Comment.nvim",
			config = function()
				require("Comment").setup()
				utils.map("x", { ["<leader>/"] = { "<plug>(comment_toggle_linewise_visual)", "Comment" } })
				utils.map("n", { ["<leader>/"] = { "<plug>(comment_toggle_linewise_current)", "Comment" } })
			end,
			lazy = false,
		},
		{
			"zbirenbaum/copilot.lua",
			cmd = "Copilot",
			event = "InsertEnter",
		},
		{
			"neovim/nvim-lspconfig",
			event = "lspattach",
			dependencies = {
				"williamboman/mason-lspconfig.nvim",
				"williamboman/mason.nvim",
				"nvimdev/lspsaga.nvim",
				-- "mfussenegger/nvim-lint",
				{ -- for null-ls{{{
					"jay-babu/mason-null-ls.nvim",
					event = { "BufReadPre", "BufNewFile" },
					dependencies = {
						"jose-elias-alvarez/null-ls.nvim",
					},
				},
				-- }}}
			},
		},
		-- {
		-- 	"mhartington/formatter.nvim",
		-- },
	},
	{ --utils
		{
			"folke/zen-mode.nvim",
			lazy = false,
			opts = {
				plugins = {
					tmux = { enabled = true },
				},
			},
		},

		{
			"itchyny/calendar.vim",
			lazy = false,
			config = function()
				-- e.g config {{{
				-- let g:calendar_google_api_key = '<api key'
				-- let g:calendar_google_client_id = 'client id'
				-- let g:calendar_google_client_secret = 'client-secret'
				-- }}}

				if utils.check.file_exists(os.getenv("HOME") .. "/.cache/calendar.vim/credentials.vim") then
					vim.cmd([[
        let g:calendar_google_calendar = 1
        let g:calendar_google_task = 1
        source ~/.cache/calendar.vim/credentials.vim
        ]])
					utils.map("n", { ["<leader>uC"] = { "<cmd>Calendar<CR>", "Calender" } })
				end
			end,
		},
		{
			"axieax/urlview.nvim",
			lazy = false,
			opts = {
				default_title = "Links:",
				default_picker = "native",
				default_prefix = "https://",
				default_action = "system",
			},
		},
		{ "christoomey/vim-tmux-navigator", lazy = false },
		{
			"kevinhwang91/nvim-ufo",
			requires = "kevinhwang91/promise-async",
			config = function()
				vim.keymap.set("n", "zR", require("ufo").openAllFolds)
				vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
			end,
		},
		{
			"NvChad/nvim-colorizer.lua",
			lazy = false,
			opts = {
				filetypes = config.colorizer.filetypes,
				user_default_options = {
					RGB = true,
					RRGGBB = true,
					names = true,
					RRGGBBAA = true,
					AARRGGBB = true,
					rgb_fn = true,
					hsl_fn = true,
					css = true,
					css_fn = true,
					mode = "background",
					tailwind = true,
					sass = { enable = true, parsers = { "css" } },
					virtualtext = "■",
					always_update = false,
				},
			},
		},

		{
			"folke/which-key.nvim",
			event = "VeryLazy",
			init = function()
				vim.o.timeout = true
				vim.o.timeoutlen = 300
			end,
			opts = { -- for config -> https://github.com/folke/which-key.nvim
				window = {
					border = config.border or "rounded",
				},
				layout = {
					align = "center",
					height = {
						min = 1,
					},
				},
			},
		},

		{
			"vimwiki/vimwiki",
			lazy = false,
		},

		-- {
		-- 	"3rd/image.nvim",
		-- 	lazy = false,
		-- 	opts = {
		-- 		backend = "ueberzug",
		-- 		max_width = 50,
		-- 		max_height = 50,
		-- 		integrations = {
		-- 			markdown = {
		-- 				only_render_image_at_cursor = true,
		-- 			},
		-- 		},
		-- 	},
		-- },
		{
			"mbbill/undotree",
			lazy = false,
		},

		{
			"nvim-telescope/telescope.nvim",
			tag = "0.1.2",

			dependencies = {
				"nvim-lua/plenary.nvim",
				{ "folke/todo-comments.nvim", config = true },
				{ "nvim-telescope/telescope-project.nvim", lazy = false },
				"nvim-telescope/telescope-media-files.nvim",
				-- "debugloop/telescope-undo.nvim",
				{
					"nvim-telescope/telescope-fzf-native.nvim",
					build = "make",
				},
			},
		},
		{
			"nvim-tree/nvim-tree.lua",
			version = "*",
			lazy = false,
			cmd = { "NvimTreeToggle" },
			dependencies = {
				"nvim-tree/nvim-web-devicons",
			},
		},
		{
			"akinsho/bufferline.nvim",
			version = "*",
			dependencies = "nvim-tree/nvim-web-devicons",
		},

		{
			"j-hui/fidget.nvim",
			lazy = false,
			branch = "legacy",
			opts = {
				text = {
					spinner = "moon",
				},
				window = {
					relative = "win", -- where to anchor, either "win" or "editor"
					blend = 20, -- &winblend for the window
					border = config.border or "rounded", -- style of border for the fidget window
				},
			},
		},
		{
			"rcarriga/nvim-notify",
			config = function()
				require("notify").setup({
					background_colour = "#000000",
					render = "compact",
					stages = "fade_in_slide_out",
					top_down = false,
				})
			end,
		},

		-- {
		-- 	"folke/noice.nvim",
		-- 	event = "VeryLazy",
		-- 	dependencies = {
		-- 		"MunifTanjim/nui.nvim",
		-- 		{
		-- 			"rcarriga/nvim-notify",
		-- 			config = function()
		-- 				require("notify").setup({
		-- 					background_colour = "#000000",
		-- 					render = "compact",
		-- 					stages = "fade_in_slide_out",
		-- 					top_down = false,
		-- 				})
		-- 			end,
		-- 		},
		-- 	},
		-- },

		{
			"glacambre/firenvim",

			-- Lazy load firenvim
			-- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
			-- cond = not vim.g.started_by_firenvim,
			build = function()
				require("lazy").load({ plugins = "firenvim", wait = true })
				vim.fn["firenvim#install"](0)
			end,
			lazy = false,
		},
		"nvim-lualine/lualine.nvim",
		"goolord/alpha-nvim",
		{ "olimorris/persisted.nvim", lazy = false },

		{
			"stevearc/dressing.nvim",
			lazy = false,
			opts = {},
		},
		{
			"kylechui/nvim-surround",
			version = "*",
			event = "VeryLazy",
			config = true,
		},
		{
			"ethanholz/nvim-lastplace",
			event = "BufRead",
			lazy = false,
			opts = {
				lastplace_ignore_buftype = { "quickfix", "nofile", "help", "alpha" },
				lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
				lastplace_open_folds = true,
			},
		},
		{
			"iamcco/markdown-preview.nvim",
			build = "cd app && npm install",
			ft = "markdown",
			config = function()
				vim.g.mkdp_auto_start = 1
				utils.map("n", { ["<leader>pM"] = { "<cmd>MarkdownPreview<cr>", "Markdown Browser" } })
				utils.map("n", { ["<leader>pm"] = { "<cmd>Glow<cr>", "Markdwon Glow" } })
			end,
			dependencies = {
				{ "ellisonleao/glow.nvim", config = true },
			},
		},

		{
			"karb94/neoscroll.nvim",
			lazy = false,
			opts = {},
		},

		{
			"lewis6991/gitsigns.nvim",
			opts = {
				current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
			},
			lazy = false,
		},

		{
			"anuvyklack/windows.nvim",
			lazy = false,
			dependencies = {
				"anuvyklack/middleclass",
				"anuvyklack/animation.nvim",
			},
			config = true,
		},
	},
}

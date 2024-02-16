local M = {
	{ import = "plugins.list.languages" },
	"nvim-lua/plenary.nvim",
	{ "folke/neodev.nvim", config = true },
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	},
	{
		"marko-cerovac/material.nvim",
		config = require("plugins.configs.material").config,
	},
	{
		"folke/todo-comments.nvim",
		lazy = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = { "TodoTelescope" },
		init = function()
			utils.load.mappings("todo")
		end,
		config = true,
	},
	{
		"mskelton/termicons.nvim",
		requires = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		config = true,
	},
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle" },
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		init = function()
			utils.load.mappings("nvimtree")
		end,
		config = require("plugins.configs.nvim-tree").config,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			utils.load.mappings("whichkey")
		end,
		config = require("plugins.configs.whichkey").config,
	},

	-- {
	-- 	"stevearc/conform.nvim",
	-- 	config = require("plugins.configs.conform").config,
	-- },
	-- {
	-- 	"mfussenegger/nvim-lint",
	-- 	lazy = false,
	-- 	config = require("plugins.configs.nvim-lint").config,
	-- },
	{ -- for null-ls{{{
		"nvimtools/none-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"jay-babu/mason-null-ls.nvim",
		},
		init = function()
			utils.load.mappings("none_ls")
		end,
		config = require("plugins.configs.none-ls").config,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			fast_wrap = {},
			disable_filetype = { "TelescopePrompt", "vim" },
		},
	},
	{
		"numToStr/Comment.nvim",
		init = function()
			utils.load.mappings("comment")
		end,
		config = true,
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		init = function()
			utils.load.mappings("copilot")
		end,
		opts = {
			filetypes = {
				yaml = false,
				markdown = true,
				help = false,
				gitcommit = false,
				gitrebase = false,
				hgcommit = false,
				svn = false,
				cvs = false,
				["."] = false,
			},
			suggestion = {
				enable = true,
				auto_trigger = true,
			},
		},
	},

	{
		"itchyny/calendar.vim",
		cmd = { "Calendar" },
		init = function()
			utils.load.mappings("calendar")
		end,
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
			end
		end,
	},
	{ "stevearc/dressing.nvim", event = "VeryLazy" },
	{
		"NvChad/nvim-colorizer.lua",
		event = "VeryLazy",
		opts = require("plugins.configs.nvim-colorizer").options,
	},
	{
		"okuuva/auto-save.nvim",
		config = require("plugins.configs.others").auto_save,
		event = "VeryLazy",
	},
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		init = function()
			utils.load.mappings("bufferline")
		end,
		opts = require("plugins.configs.bufferline").options,
	},
	{
		"ziontee113/color-picker.nvim",
		config = true,
		event = "VeryLazy",
		init = function()
			utils.load.mappings("colorpicker")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		config = require("plugins.configs.lualine").config,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		config = require("plugins.configs.others").noice_config,
		dependencies = {
			"MunifTanjim/nui.nvim",
			{
				"rcarriga/nvim-notify",
				init = function()
					utils.load.mappings("notify")
				end,
				opts = require("plugins.configs.others").notify_options,
			},
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		lazy = false,
		ft = { "gitcommit", "diff" },
		init = require("plugins.configs.others").gitsigns_init,
		opts = require("plugins.configs.others").gitsigns,
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = true,
	},
	{
		"rest-nvim/rest.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = require("plugins.configs.others").rest_opts,
		ft = { "http" },
		init = function()
			utils.load.mappings("rest")
		end,
	},
	{
		"j-hui/fidget.nvim",
		event = "VeryLazy",
		opts = {
			progress = {
				display = {
					progress_icon = { pattern = "moon" },
				},
			},
			notification = {
				window = {
					relative = "editor", -- where to anchor, either "win" or "editor"
					winblend = 0, -- &winblend for the window
					border = "none", -- style of border for the fidget window
				}, -- options
			},
		},
	},
	{
		"ellisonleao/glow.nvim",
		config = true,
		ft = "markdown",
	},
	{
		"ellisonleao/glow.nvim",
		config = true,
		ft = "markdown",
		init = function()
			utils.load.mappings("markdown_glow")
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		ft = "markdown",
		init = function()
			utils.load.mappings("markdown")
		end,
	},
	{
		"glacambre/firenvim",
		lazy = false,
		build = function()
			require("lazy").load({ plugins = { "firenvim" }, wait = true })
			vim.fn["firenvim#install"](0)
		end,
		config = require("plugins.configs.others").firenvim,
	},
	{
		"folke/zen-mode.nvim",
		cmd = { "ZenMode" },
		init = function()
			utils.load.mappings("zen")
		end,
		opts = {
			plugins = {
				tmux = { enabled = true },
			},
		},
	},

	{
		"goolord/alpha-nvim",
		lazy = false,
		init = function()
			utils.load.mappings("alpha")
		end,
		config = require("plugins.configs.alpha").config,
	},
	{
		"3rd/image.nvim",
		ft = { "markdown" },
		opts = require("plugins.configs.others").image_opts,
	},
	{
		"gen740/SmoothCursor.nvim",
		event = "VeryLazy",
		opts = {
			cursor = "",
			disable_float_win = true,
		},
	},
	{
		"kevinhwang91/nvim-ufo",
		event = "VeryLazy",
		init = function()
			utils.load.mappings("ufo")
		end,
		config = require("plugins.configs.others").ufo,
		dependencies = { "kevinhwang91/promise-async" },
	},
	{
		"nvim-neorg/neorg",
		build = ":Neorg sync-parsers",
		cmd = { "Neorg" },
		ft = { "norg" },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = require("plugins.configs.neorg").config,
	},
	{
		"m4xshen/hardtime.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		opts = {
			restriction_mode = "hint",
			restricted_keys = {
				["j"] = {},
				["k"] = {},
			},
		},
	},
	{
		"luukvbaal/statuscol.nvim",
		event = "VeryLazy",
		config = function()
			local builtin = require("statuscol.builtin")
			require("statuscol").setup({
				-- relculright = true,
				segments = {
          { text = { "%s" }, click = "v:lua.ScSa" },
          { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
          { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
				},
			})
		end,
	},
	{
		"Shatur/neovim-session-manager",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		event = "VeryLazy",
		config = true,
		init = function()
			utils.load.mappings("nvim_session_manager")
		end,
	},
	-- {
	-- 	"codota/tabnine-nvim",
	-- 	build = "./dl_binaries.sh",
	-- 	config = require("plugins.configs.tabnine").config,
	-- },
	{
		"tzachar/cmp-tabnine",
		build = "./install.sh",
		event = "InsertEnter",
		dependencies = "hrsh7th/nvim-cmp",
		config = require("plugins.configs.tabnine").config,
	},
}

return M

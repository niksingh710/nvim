M = {}
-- add check caluse
M.border = "rounded"

M.format_on_save = true
M.transparent = true

M.ensure = {
	treesitter = {-- {{{
    "regex",
		"astro",
		"css",
		"glimmer",
		"graphql",
		"html",
		"javascript",
		"lua",
		"nix",
		"php",
		"python",
		"scss",
		"svelte",
		"tsx",
		"twig",
		"typescript",
		"vim",
		"vue",
		"c",
		"lua",
		"vim",
		"vimdoc",
		"query",
		"markdown",
		"markdown_inline",
		"html",
		"nix",
		"php",
		"python",
		"go",
	},-- }}}
	lsp = {
		"jqls",
		"lua_ls",
		"emmet_ls",
		"gopls",
		"bashls",
		"eslint",
		"marksman",
	},
	nvim_dap = {
		"delve",
	},
}

-- Null-ls setup{{{ -- if ever felt need of linter
M.null_ls = {
	formatters = {
		stylua = {},
		shfmt = {},
		prettierd = { extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } },
		goimports = {},
		gofumpt = {},
		golines = {},
		jq = {},
	},
	linters = {
		shellcheck = {},
	},
}
-- }}}

M.colorizer = {
	filetypes = {
		"json",
		"css",
		"javascript",
		"lua",
		"markdown",
		"md",
		"conf",
		"tmux",
		html = { mode = "foreground" },
		cmp_docs = { always_update = true },
	},
}

local servers = {}
local linters = {}
-- Formatter.nvim if null-ls breaks any moment {{{
local formatters = {} -- https://github.com/mhartington/formatter.nvim#configure
-- Some lsp severs include their formatters and some does not.
-- formatter.nvim gives the flexibility to choose custom formatter for filetype with custom flags
--
-- fomatters.filetype = {
--  <function> that may be a string to get the default from formatter or custom
--https://github.com/mhartington/formatter.nvim/tree/master/lua/formatter/filetypes
--<function> e.g
-- {
-- exe = "stylua",
-- args = {
--   "--search-parent-directories",
--   "--stdin-filepath",
--   util.escape_path(util.get_current_buffer_file_path()),
--   "--",
--   "-",
-- },
-- stdin = true,
-- }
-- }

formatters.lua = {
	"stylua",
}
formatters.sh = {
	"shfmt",
	"beautysh",
}

-- }}}

linters.sh = {
	"shellcheck",
}
linters.zsh = {
	"shellcheck",
}

servers.gopls = {
	completeUnimported = true,
	usePlaceholders = true,
	analyses = {
		unusedparams = true,
		shadow = true,
	},
}
servers.emmet_ls = {
	filetypes = {
		"html",
		"typescriptreact",
		"javascriptreact",
		"css",
		"sass",
		"scss",
		"less",
	},
	init_options = {
		html = {
			options = {
				-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
				["bem.enabled"] = true,
			},
		},
	},
}

servers.tsserver = {}

servers.pkgbuild_language_server = {
	cmd = { "pkgbuild-language-server", "--stdio" },
	filetypes = { "PKGBUILD" },
}

servers.lua_ls = {
	Lua = {
		diagnostics = {
			globals = { "vim" },
		},
		workspace = {
			library = {
				[vim.fn.expand("$VIMRUNTIME/lua")] = true,
				[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				[vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types"] = true,
				[vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
			},
			maxPreload = 100000,
			preloadFileSize = 10000,
		},
	},
}

M.servers = servers
M.formatters = formatters
M.linters = linters

return M

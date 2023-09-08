M = {}

M.border = "rounded"

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
M.ensure = {
	treesitter = { -- {{{
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
	}, -- }}}
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

local formatters = {} -- https://github.com/mhartington/formatter.nvim#configure

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
			globals = { "vim", "config", "utils" },
		},
		workspace = {
			library = {
				[vim.fn.expand("$VIMRUNTIME/lua")] = true,
				[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
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

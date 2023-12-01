local M = {}
M.ensure_dap = {}

M.ensure_lsp = {
	"lua_ls",
	"gopls",
	"rust_analyzer",
}

M.ensure_tree = {
	"lua",
	"markdown",
	"markdown_inline",
	"http",
	"html",
	"css",
	"js",
	"go",
	"rust",
  "regex",
  "bash",
}

-- TODO: Write a fn that will check formatters and linters and install them via using Mason

-- if lsp is not working precisely, try to set linters manually
M.linters = {
	-- lua = { "luacheck" },
	markdown = { "vale" },
}

M.formatters = {
	lua = { "stylua" },
	-- Conform will run multiple formatters sequentially
	python = { "isort", "black" },
	-- Use a sub-list to run only the first available formatter
	javascript = { { "prettierd", "prettier" } },
	go = { "gofmt", "goimports" },
	rust = { "rustfmt" },
}

M.handlers = function()
	local capabilities = require("plugins.configs.lsp").capabilities
	local on_attach = require("plugins.configs.lsp").on_attach
	local lspconfig = require("lspconfig")

	return {

		-- The first entry (without a key) will be the default handler
		-- and will be called for each installed server that doesn't have
		-- a dedicated handler.
		function(server_name) -- default handler (optional)
			require("lspconfig")[server_name].setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
		end,

		-- Next, you can provide targeted overrides for specific servers.
		["rust_analyzer"] = function()
			local rok, rust_tools = pcall(require, "rust-tools")
			if rok then
				rust_tools.setup({
					server = {
						on_attach = on_attach,
						capabilities = capabilities,
					},
				})
			end
		end,

		["lua_ls"] = function()
			lspconfig.lua_ls.setup({
				on_attach = on_attach,
				capabilities = capabilities,

				settings = {
					Lua = {
						diagnostics = {
							globals = {
								"vim",
								"utils",
								"core",
								"border",
							},
						},
						workspace = {
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
								[vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
							},
							maxPreload = 100000,
							preloadFileSize = 10000,
						},
					},
				},
			})
		end,
	}
end

M.colorizer = {
	"json",
	"css",
	"javascript",
	"lua",
	"markdown",
	"md",
	"tmux",
	html = { mode = "foreground" },
	cmp_docs = { always_update = true },
}

return M

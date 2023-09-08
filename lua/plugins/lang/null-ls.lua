return { -- for null-ls{{{
	"jose-elias-alvarez/null-ls.nvim",
	enabled = config.null_ls,
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"jay-babu/mason-null-ls.nvim",
	},

	config = function()
		-- {{{
		-- Null-ls require {{{
		local null_ls = require("null-ls")

		local mnok, mnull_ls = pcall(require, "mason-null-ls")
		if not mnok then
			-- vim.notify("Failed to load mason-null-ls")
			return
		end

		local null_ensure = {}
		for key, _ in pairs(config.null_ls.formatters or {}) do
			table.insert(null_ensure, key)
		end
		-- }}}

		for key, _ in pairs(config.null_ls.linters or {}) do
			table.insert(null_ensure, key)
		end

		local opts = {
			ensure_installed = null_ensure,
			automatic_installation = true,
		}

		local formatting = null_ls.builtins.formatting
		local diagnostics = null_ls.builtins.diagnostics

		local sources = {}
		for k, v in pairs(config.null_ls.formatters or {}) do
			if #v > 0 then
				table.insert(sources, formatting[k].with(v))
			else
				table.insert(sources, formatting[k])
			end
		end

		for k, v in pairs(config.null_ls.linters or {}) do
			if #v > 0 then
				table.insert(sources, diagnostics[k].with(v))
			else
				table.insert(sources, diagnostics[k])
			end
		end

		null_ls.setup({
			sources = sources,
		})

		mnull_ls.setup(opts)

		local wok, whichkey = pcall(require, "which-key")
		if wok then
			local mapping = {
				i = {
					name = "Info",
					n = { "<cmd>NullLsInfo<cr>", "Null LS Info" },
				},
			}
			opts = {
				prefix = "<leader>",
			}

			whichkey.register(mapping, opts)
		end -- }}}
	end,
}

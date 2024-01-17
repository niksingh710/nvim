local M = {}

local lang = require("plugins.configs.lang")

M.config = function()
	local none_ls = require("null-ls")

	local mnull_ls = require("mason-null-ls")

	local null_ensure = {}
	for key, _ in pairs(lang.none_ls.formatters or {}) do
    if key ~= "rustfmt" then -- This to avoid installing rustfmt via mason as it is already installed via rustup and deprecated in mason
      table.insert(null_ensure, key)
    end
	end

	for key, _ in pairs(lang.none_ls.linters or {}) do
		table.insert(null_ensure, key)
	end

	local opts = {
		ensure_installed = null_ensure,
		automatic_installation = true,
	}

	local formatting = none_ls.builtins.formatting
	local diagnostics = none_ls.builtins.diagnostics

	local sources = {}
	for k, v in pairs(lang.none_ls.formatters or {}) do
		if #v > 0 then
			table.insert(sources, formatting[k].with(v))
		else
			table.insert(sources, formatting[k])
		end
	end

	for k, v in pairs(lang.none_ls.linters or {}) do
		if #v > 0 then
			table.insert(sources, diagnostics[k].with(v))
		else
			table.insert(sources, diagnostics[k])
		end
	end

	none_ls.setup({
		sources = sources,
	})

	mnull_ls.setup(opts)
end

return M

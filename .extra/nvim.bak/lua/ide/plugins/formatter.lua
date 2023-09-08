local fok, formatter = pcall(require, "formatter")
if not fok then
	vim.notify("Formatter is installed?")
	return
end

local filetypes = require("formatter.filetypes")

local formatters = config.formatters or {}
local filetype = {} -- will store the imported config
for k, v in pairs(formatters) do
	local temp = {}
	for _, val in ipairs(v) do
		if type(val) == "string" then -- if string then loading default config
			table.insert(temp, filetypes[k][val])
		-- { lua ={ require("formatter.filetypes.lua").stylua, } }
		else
			table.insert(temp, val) -- inserting fn here
			-- { lua ={ <function> } } -- https://github.com/mhartington/formatter.nvim#configure
		end
	end
	filetype[k] = temp
end

local opts = {
	logging = false,
	filetype = filetype,
	["*"] = {
		-- "formatter.filetypes.any" defines default configurations for any
		-- filetype
		require("formatter.filetypes.any").remove_trailing_whitespace,
	},
}
utils.map("n", {
	["<leader>f"] = { "<cmd>Format<cr>", "Format File" },
	["<leader>F"] = { "<cmd>FormatWrite<cr>", "Format File and Save" },
})

if config.format_on_save then
	vim.api.nvim_create_autocmd("BufWritePost", {
		pattern = "*",
		nested = true,
		callback = function()
			vim.cmd("FormatWrite")
		end,
	})
end

formatter.setup(opts)

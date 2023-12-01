M = {}

local tb_merge = vim.tbl_deep_extend

M.iprint = function(args)
	-- Prints tables in nvim makes easy to debug
	print(vim.inspect(args))
end

M.filetypeSet = function()
	vim.ui.input({ prompt = "Enter FileType: " }, function(input)
		local ft = input
		if not input or input == "" then
			ft = vim.bo.filetype
		end
		vim.o.filetype = ft
	end)
end

-- check:
M.check = {
	-- Provides check fn to check commands and files etc.

	vimcmd = function(string)
		if vim.fn.exists(":" .. string) > 0 then
			return true
		end
		return false
	end,

	file_exists = function(file)
		local f = io.open(file, "rb")
		if f then
			f:close()
		end
		return f ~= nil
	end,

	lines_from_file = function(file)
		if not M.file_exists(file) then
			return {}
		end
		local lines = {}
		for line in io.lines(file) do
			lines[#lines + 1] = line
		end
		return lines
	end,
}
--

M.load = {}

M.load.mappings = function(section, options)
	mapping_data = require("core.mappings")[section]
	if not mapping_data then
		return
	end
	for mode, mode_values in pairs(mapping_data) do
		local d_opts = tb_merge("force", { mode = mode }, options or {})
		for keybind, info in pairs(mode_values) do
			local opts = tb_merge("force", d_opts, info.opts or {})
			info.opts, opts.mode = nil, nil
			opts.desc = info[2]
			vim.keymap.set(mode, keybind, info[1], opts)
		end
	end
end

return M

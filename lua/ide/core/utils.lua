M = {}

M.map = function(mode, mappings, opts)
	-- enabled easy mapping syntax
	-- local mapping = {
	--  ["jk"] = "<esc>",
	--  ["<c-s>"] = { ":w<cr>", "Save" },
	-- }
	-- map( "n", mapping, {})

	for k, v in pairs(mappings) do
		opts = opts or {}
		local default = {
			noremap = true,
			silent = true,
		}
		opts = vim.tbl_deep_extend("force", default, opts)
		local value = v
		local desc = ""
		if type(v) == "table" then
			value, desc = v[1], v[2]
		end
		opts["desc"] = desc
		vim.keymap.set(mode, k, value, opts)
	end
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

local count_bufs_by_type = function(loaded_only)
	loaded_only = (loaded_only == nil and true or loaded_only)
	local count = { normal = 0, acwrite = 0, help = 0, nofile = 0, nowrite = 0, quickfix = 0, terminal = 0, prompt = 0 }
	local buftypes = vim.api.nvim_list_bufs()
	for _, bufname in pairs(buftypes) do
		if (not loaded_only) or vim.api.nvim_buf_is_loaded(bufname) then
			local buftype = vim.api.nvim_buf_get_option(bufname, "buftype")
			buftype = buftype ~= "" and buftype or "normal"
			count[buftype] = count[buftype] + 1
		end
	end
	return count
end

M.close_buffer = function()
	local bufTable = count_bufs_by_type()
	if bufTable.normal <= 1 then
		vim.api.nvim_exec([[:q]], true)
	else
		vim.api.nvim_exec([[:bd]], true)
	end
end

M.cwd_to_buf = function(bufnr)
	local ntok, nvimtree_api = pcall(require, "nvim-tree.api")
	if not ntok then
		vim.notify("Nvimtree call Failed!!")
		return
	end

	nvimtree_api.tree.find_file({ buf = bufnr, update_root = true, focus = true })
end

return M

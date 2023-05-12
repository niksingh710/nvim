-- Simple Function to send notification on the Editor
function notify(string, state)
	vim.notify(string, state)
end

-- Functions to set keyboard mapping from a table
function map(mode, mapping, wk)
	if wk then
		local whichkey = srequire("which-key")
		if not whichkey then
			return
		end
		whichkey.register(mapping, {
			mode = "n", -- NORMAL mode
			-- prefix: use "<leader>f" for example for mapping everything related to finding files
			-- the prefix is prepended to every mapping part of `mappings`
			prefix = "",
			buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
			silent = true, -- use `silent` when creating keymaps
			noremap = true, -- use `noremap` when creating keymaps
			nowait = false, -- use `nowait` when creating keymaps
		})
	else
		for k, v in pairs(mapping) do
			local opts = { noremap = true, silent = true }
			local value, desc = v, "No Description!!"
			if type(v) == "table" then
				value, desc = v[1], v[2]
				if v[3] then
					opts = v[3]
				end
			end
			opts["desc"] = desc
			vim.keymap.set(mode, k, value, opts)
		end
	end
end

-- SafeRequire Functions
function srequire(string)
	local status, required = pcall(require, string)
	if not status then
		notify("Failed in loading " .. string)
		return nil
	end
	return required
end

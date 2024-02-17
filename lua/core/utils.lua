local M = {}
M.mappings = function(tbl, options)
  ---@diagnostic disable-next-line: lowercase-global
  for mode, values in pairs(tbl) do
    local gopts = vim.tbl_deep_extend("force", { mode = mode }, options or { silent = true })
    for keybind, info in pairs(values) do
      local opts = vim.tbl_deep_extend("force", gopts, info.opts or {})
      info.opts, opts.mode = nil, nil
      opts.desc = info[2]

      vim.keymap.set(mode, keybind, info[1], opts)
    end
  end
end

M.toggle_diagnostics_ghost_text = function()
  if vim.diagnostic.config().virtual_text == false then
    vim.diagnostic.config({
      virtual_text = {
        source = "always",
        prefix = "●",
      },
    })
  else
    vim.diagnostic.config({
      virtual_text = false,
    })
  end
end

M.toggle_diagnostics = function()
  if vim.g.diagnostics_visible then
    vim.g.diagnostics_visible = false
    vim.diagnostic.disable()
  else
    vim.g.diagnostics_visible = true
    vim.diagnostic.enable()
  end
end

M.setFiletype = function()
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
return M

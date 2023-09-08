-- The functions that i prefer to use globally
M = {}

-- map: {{{
M.map = function(mode, mappings, wk, opts)
  -- mode:     [n, i, x, v]
  -- mappings: {                                         -- Without which key (wk)
  --            ["jk"] = "<esc>",
  --            ["<c-s>"] = { ":w<cr>", "Save" }        -- second arg will become description
  --           }
  -- mappings: {                                         -- With which key
  --             ["<leader>"] = {
  --               ["o"] = {
  --                 name = "Outline",
  --                 ["o"] = { "<cmd>Lspsaga outline<cr>", "Outline" },
  --                 ["p"] = { "<cmd>TSPlaygroundToggle<cr>", "Playground" },
  --               },
  --               ["l"] = {
  --                 name = "LSP",
  --                 w = { "<cmd>Lspsaga show_workspace_diagnostics<CR>", "Workspace Diagnostics" },
  --                 d = { "<cmd>Lspsaga show_buf_diagnostics<CR>", "Line Diagnostics" },
  --                 a = { "<cmd>Lspsaga code_action<CR>", "Code Action" },
  --               },
  --             },
  --           }
  -- wk:    boolean determines if mapping is which key type or not
  -- opts:  options for which key or normal keymapping
  if wk then
    local status, whichkey = pcall(require, "which-key")
    if not status then
      local msg = "calling which key failed"
      vim.notify(msg, vim.log.levels.ERROR)
      return
    end
    opts = opts or {}
    local default = {
      mode = mode,
      prefix = "",
      buffer = nil,
      silent = true,
      nowait = false,
    }
    opts = vim.tbl_deep_extend("force", default, opts)
    whichkey.register(mappings, opts)
  else
    for k, v in pairs(mappings) do
      opts = opts or {}
      local default = {
        noremap = true,
        silent = true,
      }
      opts = vim.tbl_deep_extend("force", default, opts)
      local value = v
      if type(v) == "table" then
        value, desc = v[1], v[2]
      end
      opts["desc"] = desc
      vim.keymap.set(mode, k, value, opts)
    end
  end
end
-- }}}

-- check: {{{
M.check = {
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
-- }}}

M.iprint = function(args)
  print(vim.inspect(args))
end

M.filetypeSet = function()
  vim.ui.input({ prompt = "Enter FileType: " }, function(input)
    ft=input
    if not input or input == "" then
      ft=vim.bo.filetype
    end
    vim.o.filetype = ft
  end)
end

-- filter: {{{
M.filter = function(list)
  local newLi = {}
  for _, v in ipairs(list) do
    local name = v
    if type(v) == "table" then
      name = v[1]
    end
    name = string.match(name, "/(.*)"):gsub("%-", "_"):gsub("%..-$", "")
    if override.plugins.list[name] ~= false then
      table.insert(newLi, v)
    end
  end
  return newLi
end
-- }}}

count_bufs_by_type = function(loaded_only)
  loaded_only = (loaded_only == nil and true or loaded_only)
  count = { normal = 0, acwrite = 0, help = 0, nofile = 0, nowrite = 0, quickfix = 0, terminal = 0, prompt = 0 }
  buftypes = vim.api.nvim_list_bufs()
  for _, bufname in pairs(buftypes) do
    if (not loaded_only) or vim.api.nvim_buf_is_loaded(bufname) then
      buftype = vim.api.nvim_buf_get_option(bufname, "buftype")
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

return M

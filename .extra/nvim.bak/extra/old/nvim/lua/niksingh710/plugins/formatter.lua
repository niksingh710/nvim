-- Using a custom formatter as all lsp does not contain formatters
local fstatus, formatter = pcall(require, "formatter")
if not fstatus then
  return
end
-- Utilities for creating configurations
-- local util = require("formatter.util")
local ftypes = require("formatter.filetypes")
-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands

local status, lang = pcall(require, "niksingh710.languages")
local formatters = lang.formatters
if not status then
  formatters = {}
end
local filetype = {}

for k, v in pairs(formatters) do
  local tempTable = {}
  for _, val in ipairs(v) do
    if type(val) == "string" then
      table.insert(tempTable, ftypes[k][val])
    else
      table.insert(tempTable, val)
    end
  end
  filetype[k] = tempTable
end
formatter.setup({
  -- Enable or disable logging
  logging = true,
  -- Set the log level
  log_level = vim.log.levels.WARN,
  -- All formatter configurations are opt-in
  filetype = filetype,
})

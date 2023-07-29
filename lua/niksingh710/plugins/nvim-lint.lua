local nlstatus, linter = pcall(require, "lint")
if not nlstatus then
  return
end

local status, lang = pcall(require, "niksingh710.languages")
local linters = lang.linters
if not status then
  linters = {}
end

linter.linters_by_ft = linters

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    linter.try_lint()
  end,
})

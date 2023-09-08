local lok, lint = pcall(require, "lint")
if not lok then
	vim.notify("Failed to load linter")
	return
end
lint.linters_by_filetype = config.linters or {}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		lint.try_lint()
	end,
})

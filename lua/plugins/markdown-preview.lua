return {
	"iamcco/markdown-preview.nvim",
	build = "cd app && npm install",
	ft = "markdown",
	enabled = config.markdown_preview,
	keys = {

		{ "<leader>pM", "<cmd>MarkdownPreview<cr>", desc = "Markdown Browser" },
	},
	config = function()
		vim.g.mkdp_auto_start = 1
	end,
}

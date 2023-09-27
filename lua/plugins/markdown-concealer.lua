return {
	"preservim/vim-markdown",
	ft = "markdown",
	dependencies = { "godlygeek/tabular" },
	config = function()
		-- Define match groups
		vim.cmd("highlight link markdownH1Delimiter markdownH1")
		vim.cmd("highlight link markdownH2Delimiter markdownH2")
		vim.cmd("highlight link markdownH3Delimiter markdownH3")
		vim.cmd("highlight link markdownH4Delimiter markdownH4")
		vim.cmd("highlight link markdownH5Delimiter markdownH5")
		vim.cmd("highlight link markdownH6Delimiter markdownH6")

		-- Define syntax regions
		vim.cmd([[
  syntax region markdownH1
        \ matchgroup=markdownH1Delimiter
        \ start=" \{,3}#\s"
        \ end="#*\s*$"
        \ keepend oneline
        \ contains=@markdownInline,markdownAutomaticLink contained
]])

		vim.cmd([[
  syntax region markdownH2
        \ matchgroup=markdownH2Delimiter
        \ start=" \{,3}##\s"
        \ end="#*\s*$"
        \ keepend oneline
        \ contains=@markdownInline,markdownAutomaticLink contained
]])

		vim.cmd([[
  syntax region markdownH3
        \ matchgroup=markdownH3Delimiter
        \ start=" \{,3}###\s"
        \ end="#*\s*$"
        \ keepend oneline
        \ contains=@markdownInline,markdownAutomaticLink contained
]])

		vim.cmd([[
  syntax region markdownH4
        \ matchgroup=markdownH4Delimiter
        \ start=" \{,3}####\s"
        \ end="#*\s*$"
        \ keepend oneline
        \ contains=@markdownInline,markdownAutomaticLink contained
]])

		vim.cmd([[
  syntax region markdownH5
        \ matchgroup=markdownH5Delimiter
        \ start=" \{,3}#####\s"
        \ end="#*\s*$"
        \ keepend oneline
        \ contains=@markdownInline,markdownAutomaticLink contained
]])

		vim.cmd([[
  syntax region markdownH6
        \ matchgroup=markdownH6Delimiter
        \ start=" \{,3}######\s"
        \ end="#*\s*$"
        \ keepend oneline
        \ contains=@markdownInline,markdownAutomaticLink contained
]])
	end,
}

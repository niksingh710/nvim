return {
	"3rd/image.nvim",
	enabled = config.image,
	ft = { "markdown", "vimwiki" },
	opts = {
		backend = "ueberzug",
		max_width = 50,
		max_height = 50,
		integrations = {
			markdown = {
				only_render_image_at_cursor = true,
			},
		},
	},
}

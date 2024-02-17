return {
  "NvChad/nvim-colorizer.lua",
  event = "VeryLazy",
  opts = {
    filetypes = lang.colorizer or {},
    user_default_options = {
      RGB = true,
      RRGGBB = true,
      names = false,
      RRGGBBAA = true,
      AARRGGBB = true,
      rgb_fn = true,
      hsl_fn = true,
      css = true,
      css_fn = true,
      mode = "background",
      tailwind = true,
      sass = { enable = true, parsers = { "css" } },
      virtualtext = "■",
      always_update = true,
    },
  },
}

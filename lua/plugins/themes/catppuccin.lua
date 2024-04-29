return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  lazy = false,
  opts = {
    transparent_background = true, -- disables setting the background color.
    integrations = {
      telescope = {
        enabled = true,
        style = "nvchad",
      },
    },
  },
}

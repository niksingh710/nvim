vim.g.material_style = "deep ocean"

M.config = function()

  local material = require "material"
  local colors = require "material.colors"
  local options = {
    contrast = {
      terminal = true, -- Enable contrast for the built-in terminal
      sidebars = true, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
      floating_windows = true, -- Enable contrast for floating windows
      cursor_line = true, -- Enable darker background for the cursor line
      non_current_windows = true, -- Enable contrasted background for non-current windows
      filetypes = {}, -- Specify which filetypes get the contrasted (darker) background
    },

    styles = { -- Give comments style such as bold, italic, underline etc.
      comments = { --[[ italic = true ]]
        italic = true,
      },
      strings = { --[[ bold = true ]]
        bold = true,
      },
      keywords = { --[[ underline = true ]]
        italic = true,
      },
      functions = { --[[ bold = true, undercurl = true ]]
        bold = true,
        -- undercurl = true,
      },
      variables = {},
      operators = {},
      types = {},
    },

    plugins = { -- Uncomment the plugins that you use to highlight them
      -- Available plugins:
      "dap",
      "dashboard",
      "gitsigns",
      "hop",
      "indent-blankline",
      "lspsaga",
      "mini",
      "neogit",
      "neorg",
      "nvim-cmp",
      "nvim-navic",
      "nvim-tree",
      "nvim-web-devicons",
      "sneak",
      "telescope",
      "trouble",
      "which-key",
    },

    disable = {
      colored_cursor = true, -- Disable the colored cursor
      borders = true, -- Disable borders between verticaly split windows
      background = true, -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
      term_colors = true, -- Prevent the theme from setting terminal colors
      eob_lines = true, -- Hide the end-of-buffer lines
    },

    high_visibility = {
      lighter = true, -- Enable higher contrast text for lighter style
      darker = true, -- Enable higher contrast text for darker style
    },

    lualine_style = "stealth", -- Lualine style ( can be 'stealth' or 'default' )

    async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)

    custom_colors = nil, -- If you want to override the default colors, set this to a function

    custom_highlights = {
      DapBreakpoint = { fg = "#993939" },
      DapLogPoint = { fg = "#61afef" },
      DapStopped = { fg = "#98c379" },
      TelescopeMatching = { fg = colors.main.orange },
      TelescopeSelection = { fg = colors.fg, bg = colors.backgrounds.cursor_line, bold = true },
      TelescopePromptPrefix = { bg = colors.backgrounds.cursor_line },
      TelescopePromptNormal = { bg = colors.backgrounds.cursor_line },
      TelescopeResultsNormal = { bg = colors.backgrounds.floating_windows },
      TelescopePreviewNormal = { bg = colors.backgrounds.floating_windows },
      TelescopePromptBorder = { bg = colors.backgrounds.cursor_line, fg = colors.backgrounds.cursor_line },
      TelescopeResultsBorder = {
        bg = colors.backgrounds.floating_windows,
        fg = colors.backgrounds.floating_windows,
      },
      TelescopePreviewBorder = {
        bg = colors.backgrounds.floating_windows,
        fg = colors.backgrounds.floating_windows,
      },
      
      PMenu = { bg = "none" }, -- make cmp menu transparent
      TelescopePromptTitle = { bg = colors.main.purple, fg = colors.backgrounds.floating_windows },
      TelescopeResultsTitle = { fg = colors.backgrounds.floating_windows },
      TelescopePreviewTitle = { bg = colors.main.green, fg = colors.backgrounds.floating_windows },
      SLGreen = { fg = colors.main.green },
      SLGitIcon = { fg = colors.main.orange },
    }, -- Overwrite highlights with your own
  }
  material.setup(options)
end

return M

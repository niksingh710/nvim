-- This executes at end
local urlview = srequire("urlview")
if urlview then
  urlview.setup({
    default_title = "Links:",
    -- Default picker to display links with
    -- Options: "native" (vim.ui.select) or "telescope"
    default_picker = "native",
    -- Set the default protocol for us to prefix URLs with if they don't start with http/https
    default_prefix = "https://",
    default_action = "system",
  })
  map("n", {
    ["<leader>"] = {
      ["U"] = {
        name = "Url Handler",
        ["o"] = { "<Cmd>UrlView buffer<CR>", "Browser!!" },
        ["c"] = { "<Cmd>UrlView buffer action=clipboard<CR>", "Clipboard!!" },
      },
    },
  }, true)
end

if vim.fn.exists(":Twilight") ~= 0 then
  map("n", {
    ["<leader>T"] = { "<cmd>Twilight<cr>", "Twilight" },
  })
end

if vim.fn.exists(":ZenMode") ~= 0 then
  map("n", {
    ["<leader>Z"] = { "<cmd>ZenMode<cr>", "Zen Mode" },
  })
end
--
-- local notifyvisual = srequire("notify")
-- if notifyvisual then
--   notifyvisual.setup({
--     background_colour = "#00000000",
--     render = "compact",
--   })
-- end
--
local noice = srequire("noice")
if noice then
  noice.setup({
    lsp = {
      -- override markdown rendering
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
      },
      progress = {
        enabled = false,
      },
      hover = {
        enabled = false,
      },
      signature = {
        enabled = false,
      },
    },
    cmdline = {
      format = {
        help = { pattern = "^:%s*tab he?l?p?%s+", icon = "" },
      },
    },
    -- you can enable a preset for easier configuration
    presets = {
      bottom_search = true,        -- use a classic bottom cmdline for search
      -- command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false,           -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true,        -- add a border to hover docs and signature help
      command_palette = {
        views = {
          cmdline_popup = {
            position = {
              row = 60,
              col = "50%",
            },
            size = {
              min_width = 60,
              width = "auto",
              height = "auto",
            },
          },
          popupmenu = {
            relative = "editor",
            position = {
              row = 40,
              col = "50%",
            },
            size = {
              width = 60,
              height = "auto",
              max_height = 15,
            },
            border = {
              style = "rounded",
              padding = { 0, 1 },
            },
            win_options = {
              winhighlight = { Normal = "Normal", FloatBorder = "NoiceCmdlinePopupBorder" },
            },
          },
        },
      },
    },
  })
end
local lastplace = srequire("nvim-lastplace")
if lastplace then
  lastplace.setup({
    lastplace_ignore_buftype = { "quickfix", "nofile", "help", "NvimTree", "alpha" },
    lastplace_ignore_filetype = {
      "gitcommit",
      "gitrebase",
      "svn",
      "hgcommit",
    },
    lastplace_open_folds = true,
  })
end

local neoscroll = srequire("neoscroll")
if neoscroll then
  neoscroll.setup({
    -- All these keys will be mapped to their corresponding default scrolling animation
    mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
    hide_cursor = true,        -- Hide cursor while scrolling
    stop_eof = true,           -- Stop at <EOF> when scrolling downwards
    use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
    respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
    cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
    easing_function = nil,     -- Default easing function
    pre_hook = nil,            -- Function to run before the scrolling animation starts
    post_hook = nil,           -- Function to run after the scrolling animation ends
  })
end

-- local gotopreview = srequire("goto-preview")
-- if gotopreview then
-- 	gotopreview.setup({
-- 		width = 120, -- Width of the floating window
-- 		height = 25, -- Height of the floating window
-- 		default_mappings = false, -- Bind default mappings
-- 		debug = false, -- Print debug information
-- 		opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
-- 		post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
-- 	})
-- 	local mapping = {
-- 		["gp"] = {
-- 			p = { "<cmd>lua require('goto-preview').close_all_win()<CR>", "Close Preview Window" },
-- 			d = { "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", "Definations" },
-- 			i = { "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", "Definations" },
-- 			r = { "<cmd>lua require('goto-preview').goto_preview_references()<CR>", "References" },
-- 			t = { "<cmd>lua require('goto-preview').goto_preview_type_definations()<CR>", "Type Definations" },
-- 		},
-- 	}
-- 	map("n", mapping, true)
-- end
-- local persistence = srequire("persistence")
-- if persistence then
--   persistence.setup({
--     dir = vim.fn.expand(vim.fn.stdpath("config") .. "/session/"),
--     options = { "buffers", "curdir", "tabpages", "winsize" },
--   })
local mappings = {
  ["<leader>"] = {
    ["v"] = {
      name = "split",
      v = { "<cmd>vsplit<cr>", "Vertical Split" },
      s = { "<cmd>split<cr>", "Horizonatal Split" },
    },
    ["S"] = {
      name = "Session",
      d = { ":SessionLoad<cr>", "Restore last session for current dir" },
      ["."] = { ":SessionLoadLast<cr>", "Restore last session" },
      q = { ":SessionDelete<cr>:quit!<cr>", "Quit without saving session" },
      l = { ":Telescope persisted<cr>", "Telescope for persisted Session" },
    },
  },
}

map("n", mappings, true)

local hypersonic = srequire("hypersonic")
if hypersonic then
  map("v", {
    ["<leader>h"] = { ":Hypersonic<cr>", "Hypersonic" },
  })
end

vim.g.firenvim_config = {
  localSettings = {
    [".*"] = {
      takeover = "never",
      cmdline = "neovim",
    },
  },
}

if vim.fn.exists(":ASToggle") ~= 0 then
  map("n", {
    ["<leader>A"] = { "<cmd>ASToggle<cr>", "Auto Save Toggle" },
  })
end

local web_devicons = srequire("nvim-web-devicons")
if web_devicons then
  local material_icon = srequire("nvim-material-icon")

  if material_icon then
    material_icon.setup({
      -- your personnal icons can go here (to override)
      -- you can specify color or cterm_color instead of specifying both of them
      -- DevIcon will be appended to `name`
      override = {
        zsh = {
          icon = "",
          color = "#428850",
          cterm_color = "65",
          name = "Zsh",
        },
      },
      -- globally enable different highlight colors per icon (default to true)
      -- if set to false all icons will have the default icon's color
      color_icons = true,
      -- globally enable default icons (default to false)
      -- will get overriden by `get_icons` option
      default = true,
    })
    web_devicons.setup({
      override = material_icon.get_icons(),
    })
  end
end

-- require('specs').setup{
--     show_jumps  = true,
--     min_jump = 30,
--     popup = {
--         delay_ms = 0, -- delay before popup displays
--         inc_ms = 10, -- time increments used for fade/resize effects
--         blend = 10, -- starting blend, between 0-100 (fully transparent), see :h winblend
--         width = 10,
--         winhl = "PMenu",
--         fader = require('specs').linear_fader,
--         resizer = require('specs').shrink_resizer
--     },
--     ignore_filetypes = {},
--     ignore_buftypes = {
--         nofile = true,
--     },
-- }

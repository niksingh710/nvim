return {
  "folke/which-key.nvim",
  "ThePrimeagen/vim-be-good",
  "DaikyXendo/nvim-material-icon",
  "vimwiki/vimwiki",
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      -- "rcarriga/nvim-notify",
    },
  },
  {
    "sudormrfbin/cheatsheet.nvim",
    dependencies = {
      { "nvim-telescope/telescope.nvim" },
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
    },
  },
  {
    "tomiis4/Hypersonic.nvim",
    cmd = "Hypersonic",
    config = true,
  },
  {
    "anuvyklack/windows.nvim",
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim",
    },
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require("windows").setup()
    end,
  },
  -- { "edluffy/specs.nvim" },
  "nvim-treesitter/playground",
  -- { "echasnovski/mini.animate", version = false, config = true },
  { "folke/zen-mode.nvim", config = true },
  { "mbbill/undotree" },
  -- {
  --   "nvim-neorg/neorg",
  --   build = ":Neorg sync-parsers",
  --   dependencies = { { "nvim-lua/plenary.nvim" }, { "nvim-neorg/neorg-telescope" } },
  -- },

  -- lazy.nvim

  { "folke/todo-comments.nvim",                 config = true },
  "christoomey/vim-tmux-navigator",
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.1",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "jvgrootveld/telescope-zoxide" },
      { "cljoly/telescope-repo.nvim" },
      -- { "AckslD/nvim-neoclip.lua",     config = true },
    },
  },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "mrjones2014/nvim-ts-rainbow",
      "drybalka/tree-climber.nvim",
      "nvim-treesitter/nvim-treesitter-textobjects",
      { "nvim-treesitter/nvim-treesitter-context" },
      { "folke/twilight.nvim",                    config = true },
      { "windwp/nvim-ts-autotag",                 config = true },
    },
    build = ":TSUpdate",
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      -- {
      --   "j-hui/fidget.nvim",
      --   branch = "legacy",
      --   config = function()
      --     require("fidget").setup({
      --       text = {
      --         spinner = "moon",
      --       },
      --       window = {
      --         relative = "win", -- where to anchor, either "win" or "editor"
      --         blend = 20, -- &winblend for the window
      --         zindex = nil, -- the zindex value for the window
      --         border = "none", -- style of border for the fidget window
      --       },
      --     })
      --   end,
      -- },
      "folke/neodev.nvim",
    },
  },
  --"github/copilot.vim",
  {
    "zbirenbaum/copilot-cmp",
    dependencies = {
      "lukas-reineke/cmp-under-comparator",
      {
        "zbirenbaum/copilot.lua",
        config = function()
          require("copilot").setup({
            -- suggestion = { enabled = false },
            panel = { enabled = false },
            filetypes = {
              yaml = true,
              markdown = true,
              help = true,
              gitcommit = true,
              gitrebase = true,
              hgcommit = true,
              svn = true,
              cvs = true,
              ["."] = true,
            },
            suggestion = {
              enabled = true,
              auto_trigger = true,
              debounce = 75,
              keymap = {
                accept = "<c-l>",
                next = "<c-]>",
                prev = "<c-[>",
                dismiss = "<C-e>",
              },
            },
          })
        end,
        -- cmd = "Copilot",
        -- event = "InsertEnter",
      },
    },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require("lsp_signature").on_attach()
    end,
  },
  {
    -- Autocompletion
    "hrsh7th/nvim-cmp",
    dependencies = {
      "onsails/lspkind.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-buffer",
      -- "hrsh7th/cmp-path",
      "FelipeLema/cmp-async-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-calc",
      { "L3MON4D3/LuaSnip", dependencies = { "rafamadriz/friendly-snippets" } },
      "saadparwaiz1/cmp_luasnip",
      "uga-rosa/cmp-dictionary",
      -- "f3fora/cmp-spell",
      "David-Kunz/cmp-npm",
      "tamago324/cmp-zsh",
      "Shougo/deol.nvim",
      -- "tzachar/cmp-ai",
    },
  },
  {
    "stevearc/dressing.nvim",
    config = true,
  },
  {
    "windwp/nvim-autopairs",
    config = true,
  },
  {
    "numToStr/Comment.nvim",
    config = true,
  },
  "nvim-lualine/lualine.nvim",
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
  },
  { "jose-elias-alvarez/null-ls.nvim" },
  "lukas-reineke/indent-blankline.nvim",
  "goolord/alpha-nvim",
  "axieax/urlview.nvim",
  { "nvimdev/hlsearch.nvim",          event = "BufRead", config = true },
  "ellisonleao/glow.nvim",
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = "markdown",
    config = function()
      vim.g.mkdp_auto_start = 1
    end,
  },
  {
    "ethanholz/nvim-lastplace",
    event = "BufRead",
  },
  {
    "ziontee113/icon-picker.nvim",
    config = function()
      require("icon-picker").setup({})
      map("i", {
        ["<c-.>"] = "<cmd>IconPickerInsert<cr>",
      })
      map("n", {
        ["<leader>si"] = { "<cmd>IconPickerYank<cr>", "Icon Picker Yank" },
      })
    end,
  },
  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
  },

  -- {
  -- 	"ggandor/leap.nvim",
  -- 	name = "leap",
  -- 	config = function()
  -- 		require("leap").add_default_mappings()
  -- 	end,
  -- },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          -- default options: exact mode, multi window, all directions, with a backdrop
          require("flash").jump({
            search = {
              mode = function(str)
                return "\\<" .. str
              end,
            },
          })
        end,
        desc = "flash",
      },
      {
        "s",
        mode = { "n", "o", "x" },
        function()
          -- show labeled treesitter nodes around the cursor
          require("flash").treesitter()
        end,
        desc = "flash treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          -- jump to a remote location to execute the operator
          require("flash").remote()
        end,
        desc = "remote flash",
      },
      {
        "R",
        mode = { "n", "o", "x" },
        function()
          -- show labeled treesitter nodes around the search matches
          require("flash").treesitter_search()
        end,
        desc = "treesitter search",
      },
    },
  },
  {
    "glepnir/lspsaga.nvim",
    event = "lspattach",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      --please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
  {
    "nacro90/numb.nvim",
    event = "bufread",
    config = function()
      require("numb").setup({
        show_numbers = true, -- enable 'number' for the window while peeking
        show_cursorline = true, -- enable 'cursorline' for the window while peeking
      })
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "css", "scss", "html", "javascript" }, {
        rgb = true,  -- #rgb hex codes
        rrggbb = true, -- #rrggbb hex codes
        rrggbbaa = true, -- #rrggbbaa hex codes
        rgb_fn = true, -- css rgb() and rgba() functions
        hsl_fn = true, -- css hsl() and hsla() functions
        css = true,  -- enable all css features: rgb_fn, hsl_fn, names, rgb, rrggbb
        css_fn = true, -- enable all css *functions*: rgb_fn, hsl_fn
      })
    end,
  },
  -- {
  --   "folke/persistence.nvim",
  --   event = "bufreadpre", -- this will only start session saving when an actual file was opened
  --   lazy = true,
  -- },
  {
    "olimorris/persisted.nvim",
    config = function()
      local rtimedir = os.getenv("XDG_RUNTIME_DIR")
      require("persisted").setup({
        should_autosave = function()
          -- do not autosave if the alpha dashboard is the current filetype
          if vim.bo.filetype == "alpha" then
            return false
          end
          return true
        end,
        ignored_dirs = {
          rtimedir .. "/firenvim",
        },
      })
    end,
  },
  -- {
  --   "jackmort/chatgpt.nvim",
  --   event = "verylazy",
  --   config = function()
  --     require("chatgpt").setup({
  --       api_key_cmd = "echo $openai_api_key",
  --     })
  --   end,
  --   dependencies = {
  --     "muniftanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim",
  --   },
  -- },
  {
    "glacambre/firenvim",
    -- lazy load firenvim
    -- explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
    cond = not not vim.g.started_by_firenvim,
    build = function()
      ---@diagnostic disable-next-line: assign-type-mismatch
      require("lazy").load({ plugins = "firenvim", wait = true })
      vim.fn["firenvim#install"](0)
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },
  -- { "lukas-reineke/lsp-format.nvim", config = true },
  -- "Pocco81/auto-save.nvim",
  "imsnif/kdl.vim",
  "mg979/vim-visual-multi",
  "Pocco81/auto-save.nvim",
  "lewis6991/gitsigns.nvim",
  -- "uZer/pywal16.nvim",
  -- { "Deep-Six/pywal-lush",   dependencies = { "rktjmp/lush.nvim" } },
  -- Debuggers
  -- {
  --   "mfussenegger/nvim-dap-python",
  --   ft = "python",
  --   dependencies = {
  --     "mfussenegger/nvim-dap",
  --     {"theHamsta/nvim-dap-virtual-text",config = true},
  --     {"rcarriga/nvim-dap-ui",config = true},
  --     {"nvim-telescope/telescope-dap.nvim",config = true},
  --   },
  -- },
  {
    "stevearc/oil.nvim",
    opts = {
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<C-s>"] = "actions.select_vsplit",
        ["<C-h>"] = "actions.select_split",
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        ["<s-h>"] = "actions.parent",
        ["<s-l>"] = "actions.select",
        ["<cr>"] = "actions.select",
        ["s-<CR>"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["g."] = "actions.toggle_hidden",
      },
    },
  },
  {
    "itchyny/calendar.vim",
    config = function()
      vim.cmd([[
      let g:calendar_google_calendar = 1
      let g:calendar_google_task = 1
      source ~/.cache/calendar.vim/credentials.vim
      ]])
      map("n", { ["<leader>C"] = { ":Calendar<CR>", "Calender" } })
    end,
  },
  -- Themes
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  "nyoom-engineering/oxocarbon.nvim",
  "folke/tokyonight.nvim",
  "xiyaowong/transparent.nvim",
  {
    "marko-cerovac/material.nvim",
    opts = {
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
    },
  },
  "tiagovla/tokyodark.nvim",
  {
    "oncomouse/lushwal.nvim",
    cmd = { "LushwalCompile" },
    dependencies = {
      { "rktjmp/lush.nvim" },
      { "rktjmp/shipwright.nvim" },
    },
  },
}

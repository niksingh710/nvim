return {
  "folke/tokyonight.nvim",
  "folke/which-key.nvim",
  { "folke/zen-mode.nvim",      config = true },
  -- {
  -- 	"folke/noice.nvim",
  -- 	dependencies = {
  -- 		"MunifTanjim/nui.nvim",
  -- 		-- { "rcarriga/nvim-notify" },
  -- 	},
  -- },
  { "folke/todo-comments.nvim", config = true },
  "christoomey/vim-tmux-navigator",
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.1",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    cond = function()
      return vim.fn.executable("make") == 1
    end,
  },
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
      "nvim-treesitter/nvim-treesitter-refactor",
      { "folke/twilight.nvim",    config = true },
      { "windwp/nvim-ts-autotag", config = true },
    },
    build = ":TSUpdate",
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      { "j-hui/fidget.nvim",       config = true },
      "folke/neodev.nvim",
    },
  },
  --"github/copilot.vim",
  {
    "zbirenbaum/copilot-cmp",
    dependencies = {
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
              dismiss = "<C-]>",
            },
          },
        })
      end,
      -- cmd = "Copilot",
      -- event = "InsertEnter",
    },
    config = function()
      require("copilot_cmp").setup()
    end,
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
      "hrsh7th/cmp-emoji",
      "chrisgrieser/cmp-nerdfont",
      -- "hrsh7th/cmp-path",
      "FelipeLema/cmp-async-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-calc",
      { "L3MON4D3/LuaSnip", dependencies = { "rafamadriz/friendly-snippets" } },
      "saadparwaiz1/cmp_luasnip",
      "uga-rosa/cmp-dictionary",
      "f3fora/cmp-spell",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "David-Kunz/cmp-npm",
      "tamago324/cmp-zsh",
      "Shougo/deol.nvim",
      -- "tzachar/cmp-ai",
      {
        "codota/tabnine-nvim",
        build = "./dl_binaries.sh",
        config = function()
          require("tabnine").setup({
            exclude_filetypes = { "TelescopePrompt" },
          })
        end,
      },
      {
        "tzachar/cmp-tabnine",
        build = "./install.sh",
        dependencies = "hrsh7th/nvim-cmp",
      },
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
  "RRethy/vim-illuminate",
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
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
  },
  {
    "ggandor/leap.nvim",
    name = "leap",
    dependencies = {
      { "ggandor/flit.nvim", config = true },
    },
    config = function()
      require("leap").add_default_mappings()
    end,
  },
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
  {
    "nacro90/numb.nvim",
    event = "BufRead",
    config = function()
      require("numb").setup({
        show_numbers = true,    -- Enable 'number' for the window while peeking
        show_cursorline = true, -- Enable 'cursorline' for the window while peeking
      })
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "css", "scss", "html", "javascript" }, {
        RGB = true,      -- #RGB hex codes
        RRGGBB = true,   -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true,   -- CSS rgb() and rgba() functions
        hsl_fn = true,   -- CSS hsl() and hsla() functions
        css = true,      -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true,   -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end,
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    lazy = true,
  },
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup({
        api_key_cmd = "echo $OPENAI_API_KEY",
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
  {
    "glacambre/firenvim",
    -- Lazy load firenvim
    -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
    cond = not not vim.g.started_by_firenvim,
    build = function()
      ---@diagnostic disable-next-line: assign-type-mismatch
      require("lazy").load({ plugins = "firenvim", wait = true })
      vim.fn["firenvim#install"](0)
    end,
  },
  "arkav/lualine-lsp-progress",
}

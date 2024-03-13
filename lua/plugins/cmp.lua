return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      -- cmp sources plugins
      {
        "onsails/lspkind.nvim", -- for icons
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        {
          "https://codeberg.org/FelipeLema/cmp-async-path",
          -- dir = "/home/niksingh710/repos/cmp-async-path",
        },
        "hrsh7th/cmp-cmdline",
      },
      {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",
        dependencies = {
          "rafamadriz/friendly-snippets",
          "saadparwaiz1/cmp_luasnip",
        },
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(opts)
          require("luasnip").config.set_config(opts)

          -- vscode format
          require("luasnip.loaders.from_vscode").lazy_load()

          -- snipmate format
          require("luasnip.loaders.from_snipmate").load()

          -- lua format
          require("luasnip.loaders.from_lua").load()
        end,
      },
    },
    opts = {
      completion = {
        completeopt = "menu,menuone",
      },
      window = {
        completion = {
          border = border or "rounded",
          scrollbar = false,
        },
        documentation = {
          border = border or "rounded",
        },
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      sources = vim.tbl_deep_extend("force", lang.cmp.sources or {}, {
        { name = "async_path" }, -- file paths
        -- { name = "path" },
        { name = "nvim_lsp_signature_help" }, -- display function signatures with current parameter emphasized
        { name = "nvim_lsp", keyword_length = 3 }, -- from language server
        { name = "nvim_lua", keyword_length = 2 }, -- complete neovim's Lua runtime API such vim.lsp.*
        { name = "luasnip" },
        { name = "buffer", keyword_length = 2 }, -- source current buffer
        { name = "cmp_tabnine" },
      }),
    },
    config = function(_, opts)
      local cmp = require("cmp")
      local lsnip = require("luasnip")

      -- setup cmp for autopairs
      local aok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
      if aok then
        require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end

      local mappings = {
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),

        ["<c-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<c-d>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),

        ["<C-e>"] = cmp.mapping({
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        }),

        -- Making Ctrl-Enter accept the top entry instead of Enter
        ["<c-CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        }),
        ["<CR>"] = cmp.mapping({
          i = function(fallback)
            fallback()
          end,
        }),

        ["<c-l>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif lsnip.expand_or_jumpable() then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<c-h>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif lsnip.jumpable(-1) then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
          else
            fallback()
          end
        end, { "i", "s" }),
      }

      local copk, _ = pcall(require, "copilot")
      if copk then
        vim.g.copilot_no_tab_map = true
        vim.g.copilot_assume_mapped = true
        vim.g.copilot_tab_fallback = ""

        local suggestion = require("copilot.suggestion")
        mappings["<c-space>"] = cmp.mapping(function(fallback)
          if suggestion.is_visible() then
            suggestion.accept()
          elseif cmp.visible() then
            cmp.select_next_item()
          elseif require("luasnip").expand_or_jumpable() then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
          else
            fallback()
          end
        end, { "i", "s" })
      end

      local ok, lspkind = pcall(require, "lspkind")
      if ok then
        -- setting highlights for
        vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
        vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#CA42F0" })
        vim.api.nvim_set_hl(0, "CmpItemKindCrate", { fg = "#F64D00" })
        vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#FDE030" })

        opts.formatting = {
          format = lspkind.cmp_format({
            mode = "symbol", -- show only symbol annotations
            maxwidth = 80, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            -- can also be a function to dynamically calculate max width such as
            -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
            ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            show_labelDetails = true, -- show labelDetails in menu. Disabled by default

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(entry, vim_item)
              if entry.source.name == "copilot" then
                vim_item.kind = icons.kind.Copilot
                vim_item.kind_hl_group = "CmpItemKindCopilot"
              end

              if entry.source.name == "cmp_tabnine" then
                vim_item.kind = icons.kind.TabNine
                vim_item.kind_hl_group = "CmpItemKindTabnine"
              end

              if entry.source.name == "crates" then
                vim_item.kind = icons.misc.Package
                vim_item.kind_hl_group = "CmpItemKindCrate"
              end

              if entry.source.name == "lab.quick_data" then
                vim_item.kind = icons.misc.CircuitBoard
                vim_item.kind_hl_group = "CmpItemKindConstant"
              end

              if entry.source.name == "emoji" then
                vim_item.kind = icons.misc.Smiley
                vim_item.kind_hl_group = "CmpItemKindEmoji"
              end
              return vim_item
            end,
          }),
        }
      end

      opts.formatting.fields = { "kind", "abbr", "menu" }
      opts.mapping = mappings
      cmp.setup(opts)
    end,
  },
}

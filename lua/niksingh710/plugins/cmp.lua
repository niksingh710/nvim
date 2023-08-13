local cstatus, cmp = pcall(require, "cmp")
if not cstatus then
  return
end

local snipstatus, luasnip = pcall(require, "luasnip")
if not snipstatus then
  return
end
require("luasnip/loaders/from_vscode").lazy_load()

luasnip.config.setup({})

-- utility fn {{{
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
-- }}}

local opts = {
  completion = {
    completeopt = "menu,menuone,noinsert",
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  mapping = { -- {{{
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),

    ["<c-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<c-d>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    -- ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<cr>"] = cmp.mapping({
      i = function(fallback)
        fallback()
      end,
      s = function(fallback)
        fallback()
      end,
      c = function(fallback)
        fallback()
      end,
    }),
    ["<c-CR>"] = cmp.mapping({
      i = function(fallback)
        if cmp.visible() or cmp.get_active_entry() then
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
        else
          fallback()
        end
      end,
      s = cmp.mapping.confirm({ select = true }),
      c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
    }),
    ["<c-l>"] = cmp.mapping(function(fallback)
      if cmp.visible() and cmp.get_active_entry() then
        cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<c-h>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    -- ["<c-h>"] = cmp.mapping(function(fallback)
    --   if luasnip.jumpable(-1) then
    --     luasnip.jump(-1)
    --   else
    --     fallback()
    --   end
    -- end, { "i", "s" }),
  },            -- }}}
  formatting = { --{{{
    fields = { "kind", "abbr", "menu" },
    max_width = 0,
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format("%s", icons.kind[vim_item.kind])
      -- vim_item.kind = string.format("%s %s", icons.kind[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      vim_item.menu = ({
        luasnip = "[Snippet]",
        nvim_lsp = "[LSP]",
        buffer = "[Buffer]",
        path = "[Path]",
        copilot = "[Copilot]",
        cmp_tabnine = "[TabNine]",
      })[entry.source.name]

      if entry.source.name == "copilot" then
        vim_item.kind = icons.git.Octoface
        vim_item.kind_hl_group = "CmpItemKindCopilot"
      end

      if entry.source.name == "cmp_tabnine" then
        vim_item.kind = icons.misc.Robot
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
    duplicates = {
      buffer = 1,
      path = 1,
      nvim_lsp = 0,
      luasnip = 1,
    },
    duplicates_default = 0,
  }, -- }}}
  sources = {
    { name = "luasnip" },
    { name = "nvim_lsp" },
    { name = "nvim_lsp_document_symbol" },
    { name = "nvim_lsp_signature_help" },
    { name = "buffer" },
    { name = "copilot" },
    { name = "async_path" },
    { name = "zsh" },
  },

  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  experimental = {
    ghost_text = false,
  },
}

local gcstatus, _ = pcall(require, "copilot")
if gcstatus then
  vim.g.copilot_no_tab_map = true
  vim.g.copilot_assume_mapped = true
  vim.g.copilot_tab_fallback = ""
  local sugg = require("copilot.suggestion")
  opts["mapping"]["<c-l>"] = cmp.mapping(function(fallback)
    if sugg.is_visible() then
      sugg.accept()
    elseif cmp.visible() and cmp.get_active_entry() then
      cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
    elseif luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    elseif has_words_before() then
      cmp.complete()
    else
      fallback()
    end
  end, { "i", "s" })
end

cmp.setup(opts)

local apairstatus, autopair = pcall(require, "autopair")
if apairstatus then
  cmp.event:on("confirm_done", autopair.on_confirm_done())
end

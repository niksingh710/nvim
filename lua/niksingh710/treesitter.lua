local treesitter = srequire("nvim-treesitter.configs")
if not treesitter then
  return
end

treesitter.setup({
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { "c", "cpp", "go", "lua", "python", "rust", "tsx", "typescript", "vimdoc", "vim" },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
    config = {
      -- Languages that have a single comment style
      typescript = "// %s",
      css = "/* %s */",
      scss = "/* %s */",
      html = "<!-- %s -->",
      svelte = "<!-- %s -->",
      vue = "<!-- %s -->",
      json = "",
    },
  },
  textsubjects = {
    enable = false,
    keymaps = { ["."] = "textsubjects-smart", [";"] = "textsubjects-big" },
  },
  playground = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
  },
  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = true,
  refactor = {
    highlight_definitions = false,
  },

  highlight = {
    enable = true,
    -- additional_vim_regex_highlighting = { "latex" },
    use_languagetree = false,
    -- disable = function(_, buf)
    --     local max_filesize = 100 * 1024 -- 100 KB
    --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    --     if ok and stats and stats.size > max_filesize then
    --         return true
    --     end
    -- end,
  },
  indent = {
    enable = true,
    -- disable = { "python" }
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-s-L>",
      node_incremental = "<C-s-L>",
      scope_incremental = "<C-s-s>",
      node_decremental = "<C-p>",
    },
  },
  textobjects = {
    select = {
      enable = false,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    --swap = {
    -- enable = true,
    --swap_next = {
    -- ['<leader>a'] = '@parameter.inner',
    --},
    --swap_previous = {
    -- ['<leader>A'] = '@parameter.inner',
    --},
    -- },
  },
})
-- vim.cmd([[
-- set foldmethod=expr
-- set foldexpr=nvim_treesitter#foldexpr()
-- set nofoldenable                     " Disable folding at startup.
-- ]])
local context = srequire("treesitter-context")
if not context then
  return
end
context.setup({
  enable = true,           -- Enable this plugin (Can be enabled/disabled later via commands)
  max_lines = 0,           -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 0,   -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = true,
  multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
  trim_scope = "outer",    -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = "cursor",         -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
  zindex = 20,    -- The Z-index of the context window
  on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
})

local tree = srequire("tree-climber")
if not tree then
  return
end
local mappings = {
  ["<a-H>"] = { tree.goto_parent, "Parent node" },
  ["<a-L>"] = { tree.goto_child, "Child node" },
  ["<a-J>"] = { tree.goto_next, "Next node" },
  ["<a-K>"] = { tree.goto_prev, "Previous node" },
  ["[c"] = { ":lua require('treesitter-context').go_to_context()<cr>", "Goto To Context" },
  ["<c-s-h>"] = tree.highlight_node,
}
local mappingsV = {
  ["H"] = { tree.goto_parent, "Parent node" },
  ["L"] = { tree.goto_child, "Child node" },
  ["J"] = { tree.goto_next, "Next node" },
  ["K"] = { tree.goto_prev, "Previous node" },
  ["<c-s-h>"] = tree.highlight_node,
}
map("n", mappings)
map("x", mappingsV)

-- vim.keymap.set({ "n", "v", "o" }, "H", require("tree-climber").goto_parent, keyopts)
-- vim.keymap.set({ "n", "v", "o" }, "L", require("tree-climber").goto_child, keyopts)
-- vim.keymap.set({ "n", "v", "o" }, "J", require("tree-climber").goto_next, keyopts)
-- vim.keymap.set({ "n", "v", "o" }, "K", require("tree-climber").goto_prev, keyopts)
-- vim.keymap.set({ "v", "o" }, "in", require("tree-climber").select_node, keyopts)
-- vim.keymap.set("n", "<c-k>", require("tree-climber").swap_prev, keyopts)
-- vim.keymap.set("n", "<c-j>", require("tree-climber").swap_next, keyopts)
-- vim.keymap.set("n", "<c-h>", require("tree-climber").highlight_node, keyopts)
-- vim.keymap.set("n", "<c-h>", require("tree-climber").highlight_node, keyopts)
-- vim.keymap.set("n", "<c-h>", require("tree-climber").highlight_node, keyopts)
-- vim.keymap.set("n", "<c-h>", require("tree-climber").highlight_node, keyopts)

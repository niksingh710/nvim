return {
  wk = {
    ["<leader>"] = {
      ["o"] = { "<cmd>Lspsaga outline<cr>", "Outline" },
      ["l"] = {
        name = "LSP",
        w = { "<cmd>Lspsaga show_workspace_diagnostics<CR>", "Workspace Diagnostics" },
        d = { "<cmd>Lspsaga show_line_diagnostics<CR>", "Line Diagnostics" },
        a = { "<cmd>Lspsaga code_action<CR>", "Code Action" },
      },
    },
    ["g"] = {
      name = "Goto",
      d = { "<cmd>Lspsaga goto_definition<CR>", "saga Definations" },
      h = { "<cmd>Lspsaga lsp_finder<CR>", "LSP Finder" },
      R = { "<cmd>Lspsaga rename ++project<CR>", "Rename" },
      t = { "<cmd>Lspsaga goto_type_definition<CR>", "Type Definations" },
      -- l = { "<cmd>Lspsaga show_line_diagnostics<CR>", "Line Diagnostics" },
      ["p"] = {
        name = "Peek",
        d = { "<cmd>Lspsaga peek_definition<CR>", "Definations" },
        t = { "<cmd>Lspsaga peek_type_definition<CR>", "Type Definations" },
      },
    },
  },
  nor = {
    ["]e"] = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "Next Diagnostic" },
    ["[e"] = { "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Previous Diagnostic" },
    ["[E"] = {
      "<cmd>lua require('lspsaga.diagnostic').goto_prev({ severity = vim.diagnostic.severity.ERROR })<CR>",
      "Previous Error",
    },
    ["]E"] = {
      "<cmd>lua require('lspsaga.diagnostic').goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>",
      "Next Error",
    },
    ["K"] = { "<cmd>Lspsaga hover_doc<CR>", "Hover Doc" },
  },
}

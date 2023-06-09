local neorg = srequire("neorg")
if not neorg then
  return
end
neorg.setup({
  load = {
    ["core.defaults"] = {}, -- Loads default behaviour
    ["core.highlights"] = {}, -- Loads default behaviour
    ["core.concealer"] = {}, -- Adds pretty icons to your documents
    ["core.itero"] = {},
    ["core.keybinds"] = {},
    ["core.integrations.treesitter"] = {},
    ["core.neorgcmd"] = {},
    ["core.completion"] = {
      config = {
        engine = "nvim-cmp",
        name = "neorg",
      },
    },
    ["core.export.markdown"] = {},
    ["core.summary"] = {},
    ["core.integrations.nvim-cmp"] = {},
    ["core.integrations.telescope"] = {},
    ["core.dirman"] = { -- Manages Neorg workspaces
      config = {
        workspaces = {
          college = "~/norg/college",
          work = "~/norg/work",
        },
      },
    },
  },
})

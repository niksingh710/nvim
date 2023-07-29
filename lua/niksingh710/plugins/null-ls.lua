local nlstatus, null_ls = pcall(require, "null-ls")
if not nlstatus then
  return
end

formatting = null_ls.builtins.formatting
diagnostics = null_ls.builtins.diagnostics

-- Null-ls handles formatters and linters by self
local status, lang = pcall(require, "niksingh710.languages")
local linters = lang.linters
local formatters = lang.formatters
if not status then
  linters = {}
  formatters = {}
end

local sources = {}

for k, v in pairs(formatters) do
  if #v > 0 then
    table.insert(sources, formatting[k].with(v))
  else
    table.insert(sources, formatting[k])
  end
end

for k, v in pairs(linters) do
  if #v > 0 then
    table.insert(sources, diagnostics[k].with(v))
  else
    table.insert(sources, diagnostics[k])
  end
end

null_ls.setup({
  sources = sources,
})

utils.map("n", {
  ["<leader>il"] = { "<cmd>LspInfo<cr>", "Lsp Info" },
})

local wstatus, _ = pcall(require, "which-key")
if wstatus then
  utils.map("n", {
    ["<leader>"] = {
      ["i"] = { name = "Info" },
    },
  }, true)
end

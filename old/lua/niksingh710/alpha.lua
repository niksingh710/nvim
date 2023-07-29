local alpha = srequire("alpha")
if not alpha then
  return
end

local dashboard = srequire("alpha.themes.dashboard")
if not dashboard then
  return
end

dashboard.section.header.val = require("niksingh710.headers")

dashboard.section.buttons.val = {
  dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
  dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
  dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
  dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
  dashboard.button("c", "  Configuration", ":e $MYVIMRC <CR>"),
  dashboard.button("C", "  Calendar", "<cmd>Calendar<cr>"),
  -- dashboard.button(".", "  Last Session", "<cmd>lua require('persistence').load({ last = true })<cr>"),
  dashboard.button(".", "  Last Session", ":SessionLoadLast<cr>"),
  -- dashboard.button("d", "  Last Session of Dir", "<cmd>lua require('persistence').load()<cr>"),
  dashboard.button("d", "  Last Session of Dir", ":SessionLoad<cr>"),
  dashboard.button("l", "  Session List", ":Telescope persisted<cr>"),
  dashboard.button("Q", "  Quit Neovim", ":qa<CR>"),
}

dashboard.section.footer.val = "Welcome Nikhil!!"
local ok, name = pcall(require, "niksingh710.name")
if ok then
  dashboard.section.footer.val = "Welcome " .. name .. "!!"
end

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
vim.cmd([[autocmd User AlphaReady echo 'ready']])
alpha.setup(dashboard.opts)
map("n", { ["<leader>"] = { [";"] = { "<cmd>Alpha<CR>", "Dashboard" } } }, true)

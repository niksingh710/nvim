return {
  "mg979/vim-visual-multi",
  init = function()
    vim.cmd([[
    let g:VM_maps = {}
    let g:VM_maps["Exit"] = '<C-c>'
    ]])
  end,
  event = "BufEnter",
}

return {
  "lervag/vimtex",
  ft = "tex",
  init = function()
    vim.cmd([[let maplocalleader = " t"]])
    -- Use init for configuration, don't use the more common "config".
  end,
}

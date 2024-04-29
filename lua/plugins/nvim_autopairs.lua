return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function(opts)
    local npairs = require("nvim-autopairs")
    npairs.setup(opts)
    local Rule = require("nvim-autopairs.rule")

    npairs.add_rule(Rule("$$", "$$", "tex"))
  end,

  opts = {
    fast_wrap = {},
    disable_filetype = { "TelescopePrompt", "vim" },
  },
}

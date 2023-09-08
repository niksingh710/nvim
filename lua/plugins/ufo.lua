return {
			"kevinhwang91/nvim-ufo",
			dependencies = "kevinhwang91/promise-async",
      enabled = config.nvim_ufo,
			config = function()
				vim.keymap.set("n", "zR", require("ufo").openAllFolds)
				vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
			end,
		}

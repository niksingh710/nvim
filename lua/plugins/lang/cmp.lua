return {
	"hrsh7th/nvim-cmp",
	enabled = config.nvim_cmp,
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-calc",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		{ "petertriho/cmp-git", config = true },
	},
	config = function()
		-- highlights
		vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
		vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#CA42F0" })
		vim.api.nvim_set_hl(0, "CmpItemKindCrate", { fg = "#F64D00" })
		vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#FDE030" })

		local cmp = require("cmp")

		local snipok, luasnip = pcall(require, "luasnip")
		if not snipok then
			vim.notify("Failed to load luasnip")
			return
		end

		local default_cmp_sources = {
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "buffer" },
			{ name = "path" },
			{ name = "git" },
			{ name = "calc" },
		}

		local bufIsBig = function(bufnr)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
			if ok and stats and stats.size > max_filesize then
				return true
			else
				return false
			end
		end

		vim.api.nvim_create_autocmd("BufReadPre", {
			callback = function(t)
				local sources = default_cmp_sources
				if not bufIsBig(t.buf) then
					sources[#sources + 1] = { name = "treesitter", group_index = 2 }
				end
				cmp.setup.buffer({
					sources = sources,
				})
			end,
		})

		-- vscode format
		require("luasnip.loaders.from_vscode").lazy_load()
		require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.g.vscode_snippets_path or "" })

		-- snipmate format
		require("luasnip.loaders.from_snipmate").load()
		require("luasnip.loaders.from_snipmate").lazy_load({ paths = vim.g.snipmate_snippets_path or "" })

		-- lua format
		require("luasnip.loaders.from_lua").load()
		require("luasnip.loaders.from_lua").lazy_load({ paths = vim.g.lua_snippets_path or "" })

		luasnip.config.setup({})

		vim.api.nvim_create_autocmd("InsertLeave", {
			callback = function()
				if
					require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
					and not require("luasnip").session.jump_active
				then
					require("luasnip").unlink_current()
				end
			end,
		})

		local mappings = {
			["<C-k>"] = cmp.mapping.select_prev_item(),
			["<C-j>"] = cmp.mapping.select_next_item(),

			["<c-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
			["<c-d>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
			["<C-y>"] = cmp.config.disable,
			["<C-e>"] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			["<c-CR>"] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Insert,
				select = true,
			}),
			["<CR>"] = cmp.mapping({
				i = function(fallback)
					fallback()
				end,
			}),
			["<c-l>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif require("luasnip").expand_or_jumpable() then
					vim.fn.feedkeys(
						vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true),
						""
					)
				else
					fallback()
				end
			end, {
				"i",
				"s",
			}),
			["<c-h>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif require("luasnip").jumpable(-1) then
					vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
				else
					fallback()
				end
			end, {
				"i",
				"s",
			}),
		}

		local copk, _ = pcall(require, "copilot")
		if copk then
			vim.g.copilot_no_tab_map = true
			vim.g.copilot_assume_mapped = true
			vim.g.copilot_tab_fallback = ""
			local suggestion = require("copilot.suggestion")
			mappings["<c-space>"] = cmp.mapping(function(fallback)
				if suggestion.is_visible() then
					suggestion.accept()
				elseif cmp.visible() then
					cmp.select_next_item()
				elseif require("luasnip").expand_or_jumpable() then
					vim.fn.feedkeys(
						vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true),
						""
					)
				else
					fallback()
				end
			end, {
				"i",
				"s",
			})
		end

		local opts = {

			completion = {
				completeopt = "menu,menuone",
			},

			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},

			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(entry, vim_item)
					-- Kind icons
					vim_item.kind = string.format("%s", icons.kind[vim_item.kind])
					-- This concatonates the icons with the name of the item kind
					-- vim_item.kind = string.format("%s %s", icons.kind[vim_item.kind], vim_item.kind)
					vim_item.menu = ({
						luasnip = "[Snippet]",
						nvim_lsp = "[LSP]",
						buffer = "[Buffer]",
						path = "[Path]",
						copilot = "[Copilot]",
						cmp_tabnine = "[TabNine]",
					})[entry.source.name]

					-- custom icons
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
			},
			window = {
				completion = {
					scrollbar = false,
					border = config.border or "rounded",
				},
				documentation = {
					border = config.border or "rounded",
				},
			},
			sources = default_cmp_sources,
			mapping = mappings,
		}

		cmp.setup(opts)

		-- local cmdline_opts = {
		-- 	cmd = {
		-- 		mapping = cmp.mapping.preset.cmdline(),
		-- 		sources = cmp.config.sources({
		-- 			{ name = "path" },
		-- 		}, {
		-- 			{
		-- 				name = "cmdline",
		-- 				option = {
		-- 					ignore_cmds = { "Man", "!" },
		-- 				},
		-- 			},
		-- 		}),
		-- 	},
		-- 	cmd_path = {
		-- 		mapping = cmp.mapping.preset.cmdline(),
		--
		-- 		sources = {
		-- 			{ name = "buffer" },
		-- 		},
		-- 	},
		-- }
		-- cmp.setup.cmdline(":", cmdline_opts.cmd)
		-- cmp.setup.cmdline("/", cmdline_opts.cmd_path)
		--
		local aok, autopair = pcall(require, "autopair")
		if aok then
			cmp.event:on("confirm_done", autopair.on_confirm_done())
		end
	end,
}

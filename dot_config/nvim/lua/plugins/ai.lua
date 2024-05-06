return {
	{
		"olimorris/codecompanion.nvim",
		commit = "44fae9b257078bc378e5c314e990ae8df3e56486",
		pin = true,
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-telescope/telescope.nvim", -- Optional
			{
				"stevearc/dressing.nvim", -- Optional: Improves the default Neovim UI
				opts = {},
			},
		},
		config = function()
			local cc_opts = require("my-globals").get_codecompanion_opts()
			-- local adapter_name = my_globals.get_codecompanion_opts()
			-- local env = my_globals.get_codecompanion_env()
			-- local schema = my_globals.get_codecompanion_adapter_schema()

			require("codecompanion").setup({
				adapters = {
					chat = require("codecompanion.adapters").use(cc_opts.name, {
						env = cc_opts.env,
						schema = cc_opts.schema,
					}),
				},
				send_code = false,
				keymaps = {
					["<C-s>"] = "keymaps.save", -- Save the chat buffer and trigger the API
					["<C-c>"] = "keymaps.close", -- Close the chat buffer
					["q"] = "keymaps.cancel_request", -- Cancel the currently streaming request
					["gs"] = "keymaps.save_chat", -- Save the current chat
				},
			})

			require("which-key").register({
				l = {
					name = "[l]anguage models",
					a = { ":CodeCompanionActions<cr><esc>", "[a]ctions menu" },
					t = { ":CodeCompanionToggle<cr>", "[t]oggle chat window" }, -- NOTE: Doesn't work as intended if formatting is run
				},
			}, { mode = "n", prefix = "<leader>" })
		end,
	},
	{
		"folke/edgy.nvim",
		tag = "v1.8.4",
		pin = true,
		event = "VeryLazy",
		init = function()
			vim.opt.laststatus = 3
			vim.opt.splitkeep = "screen"
		end,
		opts = {
			right = {
				{
					ft = "codecompanion",
					title = require("my-globals").get_codecompanion_opts().name,
					size = { width = 0.25 },
				},
			},
			animate = { enabled = false },
			keys = {
				-- increase width
				["<c-=>"] = function(win)
					win:resize("width", 2)
				end,
				-- decrease width
				["<c-->"] = function(win)
					win:resize("width", -2)
				end,
			},
		},
	},
}

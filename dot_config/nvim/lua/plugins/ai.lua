return {
	{
		"olimorris/codecompanion.nvim",
		tag = "v11.13.1",
		pin = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-telescope/telescope.nvim",
			{
				"stevearc/dressing.nvim",
				opts = {},
			},
		},
		keys = {
			{ "<leader>lc", "<cmd>CodeCompanionChat Toggle<cr>", desc = "[c]hat window toggle" },
			{
				"<leader>la",
				"<cmd>CodeCompanionChat Add<cr>",
				mode = "v",
				desc = "[a]dd visual selection to chat",
			},
		},
		opts = {
			strategies = {
				chat = { adapter = "ollama" },
				inline = { adapter = "ollama" },
			},
			adapters = {
				ollama = function()
					return require("codecompanion.adapters").extend("ollama", {
						schema = {
							model = {
								default = os.getenv("HOME") == "/Users/nlyssogor" and "qwen2.5-coder:14b"
									or "qwen2.5-coder:32b",
							},
						},
					})
				end,
			},
			opts = {
				log_level = "DEBUG",
			},
		},
	},
	{
		"folke/edgy.nvim",
		tag = "v1.8.4",
		pin = true,
		init = function()
			vim.opt.laststatus = 3
			vim.opt.splitkeep = "screen"
		end,
		opts = {
			right = {
				{
					ft = "codecompanion",
					title = "ollama",
					size = { width = 0.25 },
				},
			},
			animate = { enabled = false },
			keys = {
				-- increase width
				["="] = function(win)
					win:resize("width", 2)
				end,
				-- decrease width
				["-"] = function(win)
					win:resize("width", -2)
				end,
			},
		},
	},
}

return {
	{
		"olimorris/codecompanion.nvim",
		tag = "v9.1.0",
		event = "VeryLazy",
		pin = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"hrsh7th/nvim-cmp",
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
		config = {
			strategies = {
				chat = { adapter = "openai" },
				inline = { adapter = "openai" },
			},
			adapters = {
				openai = function()
					local home = os.getenv("HOME")

					local url = home == "/Users/nlyssogor" and "https://api.openai.com/v1/chat/completions"
						or "https://apim-prd-quanthub-wus-3.azure-api.net/openai/deployments/gpt-4o/chat/completions?api-version=2024-02-15-preview"

					return require("codecompanion.adapters").extend("openai", {
						url = url,
						env = {
							api_key = string.format(
								'cmd:gpg --decrypt --batch --passphrase " " %s/Documents/secrets/openai-key.txt.gpg 2>/dev/null',
								home
							),
						},
						headers = {
							["Content-Type"] = "application/json",
							["api-key"] = "${api_key}",
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
		event = "VeryLazy",
		init = function()
			vim.opt.laststatus = 3
			vim.opt.splitkeep = "screen"
		end,
		opts = {
			right = {
				{
					ft = "codecompanion",
					title = "openai",
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

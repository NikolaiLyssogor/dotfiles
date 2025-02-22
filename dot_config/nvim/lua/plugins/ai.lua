return {
	{
		"olimorris/codecompanion.nvim",
		tag = "v12.7.0",
		pin = true,
		dependencies = {
			{ "nvim-lua/plenary.nvim", branch = "master" },
			"nvim-treesitter/nvim-treesitter",
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
				chat = {
					adapter = "openai",
					slash_commands = { ["file"] = { opts = { provider = "snacks" } } },
				},
				inline = { adapter = "openai" },
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

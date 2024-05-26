return {
	{
		"olimorris/codecompanion.nvim",
		commit = "5f53f6f71c544f1e277cc6aba705f5843108a307",
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-telescope/telescope.nvim",
			{
				"stevearc/dressing.nvim",
				opts = {},
			},
		},
		config = function()
			local neovim_env = os.getenv("NEOVIM_ENV")
			local strategy = "ollama"
			if neovim_env == "home" then
				strategy = "openai"
			end

			require("codecompanion").setup({
				adapters = {
					ollama = require("codecompanion.adapters").use("ollama", {
						schema = {
							model = {
								default = "llama3:8b-instruct-fp16",
							},
						},
					}),
					openai = require("codecompanion.adapters").use("openai", {
						env = {
							api_key = 'cmd:gpg --decrypt --batch --passphrase " " /Users/nlyssogor/Documents/.openai_key.txt.gpg 2>/dev/null',
						},
					}),
				},
				strategies = {
					chat = strategy,
					inline = strategy,
				},
				tools = {
					["code_runner"] = {
						enabled = false,
					},
				},
				log_level = "ERROR",
				send_code = false,
			})

			require("which-key").register({
				l = {
					name = "[l]anguage models",
					a = { ":CodeCompanionActions<cr><esc>", "[a]ctions menu" },
					t = { ":CodeCompanionToggle<cr>", "[t]oggle chat window" },
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
					title = os.getenv("NEOVIM_ENV") == "home" and "openai" or "ollama",
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

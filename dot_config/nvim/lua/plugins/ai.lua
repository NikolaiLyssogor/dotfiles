return {
	{
		"olimorris/codecompanion.nvim",
		tag = "v13.2.3",
		pin = true,
		dependencies = {
			{ "nvim-lua/plenary.nvim", branch = "master" },
			"nvim-treesitter/nvim-treesitter",
		},
		keys = {
			{
				"<leader>lc",
				function()
					vim.cmd("wincmd L")
					vim.cmd("CodeCompanionChat Toggle")
				end,
				desc = "[c]hat window toggle",
			},
			{
				"<leader>la",
				"<cmd>CodeCompanionChat Add<cr><esc>",
				mode = "v",
				desc = "[a]dd visual selection to chat",
			},
		},
		opts = {
			display = {
				chat = {
					window = {
						position = "right",
						width = 0.25,
					},
				},
			},
			strategies = {
				chat = {
					adapter = os.getenv("HOME") == "/Users/nlyssogor" and "anthropic" or "openai",
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
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            env = {
              api_key = string.format(
								'cmd:gpg --decrypt --batch --passphrase " " %s/Documents/secrets/anthropic-key.txt.gpg 2>/dev/null',
								os.getenv("HOME")
							),
            },
          })
        end,
				openai = function()
					local home = os.getenv("HOME")

					local function readUrl()
						local filename = home .. "/Documents/secrets/azure-openai-url.txt"
						local file = io.open(filename, "r")
						if not file then
							error("Could not open file: " .. filename)
						end
						local line = file:read("*line")
						file:close()
						return line
					end

					local url = home == "/Users/nlyssogor" and "https://api.openai.com/v1/chat/completions" or readUrl()

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
		},
	},
}
